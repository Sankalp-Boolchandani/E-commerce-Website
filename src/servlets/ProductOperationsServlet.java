package servlets;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

import dao.CategoryDao;
import dao.ProductDao;
import entities.Category;
import entities.Product;
import helper.FactoryProvider;

/**
 * Servlet implementation class ProductOperationsServlet
 */
@WebServlet("/ProductOperationsServlet")
@MultipartConfig
public class ProductOperationsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProductOperationsServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @throws IOException
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */

	private void processMethod(HttpServletRequest request, HttpServletResponse response) {
		try {
			PrintWriter out = response.getWriter();
			String op = request.getParameter("operation");
			if (op.equals("addcategory")) {
				String title = request.getParameter("catTitle");
				String desc = request.getParameter("catDesc");

				// Category obejct
				Category category = new Category();
				category.setCategoryTitle(title);
				category.setCategoryDescription(desc);

				// Database operations
				CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
				int catId = categoryDao.saveCategory(category);
				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Category Successfully saved. Category id = " + catId);
				response.sendRedirect("admin.jsp");
				return;

			} else if (request.getParameter("operation").equals("addproduct")) {
				String pName = request.getParameter("pName");
				String pDesc = request.getParameter("pDesc");
				int pPrice = Integer.parseInt(request.getParameter("pPrice"));
				int pDiscount = Integer.parseInt(request.getParameter("pDiscount"));
				int pQuantity = Integer.parseInt(request.getParameter("pQuantity"));
				int catId = Integer.parseInt(request.getParameter("catId"));
				Part part = request.getPart("pPhoto");

				Product p = new Product();
				p.setpName(pName);
				p.setpDesc(pDesc);
				p.setpPrice(pPrice);
				p.setpDiscount(pDiscount);
				p.setpQuantity(pQuantity);
				p.setpPhoto(part.getSubmittedFileName());
				CategoryDao cDao = new CategoryDao(FactoryProvider.getFactory());
				Category category = cDao.getCategoryById(catId);
				p.setCategory(category);

				// save product
				ProductDao pDao = new ProductDao(FactoryProvider.getFactory());
				pDao.saveProduct(p);

				// upload picture
				String path = request.getRealPath("img") + File.separator + "productimages" + File.separator
						+ part.getSubmittedFileName();
				System.out.println(path);
				try {
					FileOutputStream fos = new FileOutputStream(path);
					InputStream is = part.getInputStream();
					byte[] data = new byte[is.available()];
					is.read(data);
					fos.write(data);
					fos.close();

				} catch (Exception e) {
					// TODO: handle exception
					e.printStackTrace();
					System.out.print("inner catch");
				}

				HttpSession httpSession = request.getSession();
				httpSession.setAttribute("message", "Product Successfully saved");
				response.sendRedirect("admin.jsp");
				return;

			}

		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
			System.out.print("outer catch");
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processMethod(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		processMethod(request, response);
	}

}
