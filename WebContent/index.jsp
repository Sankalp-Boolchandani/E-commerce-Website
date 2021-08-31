<%@page import="helper.Helper"%>
<%@page import="entities.Category"%>
<%@page import="dao.CategoryDao"%>
<%@page import="org.hibernate.SessionFactory"%>
<%@page import="entities.Product"%>
<%@page import="java.util.List"%>
<%@page import="dao.ProductDao"%>
<%@page import="helper.FactoryProvider"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<%@include file="components/common_css_js.jsp"%>
<title>Ecommerce Website - Home</title>
<style type="text/css">
.discount-label {
	font-size: 10px !important;
	font-style: italic !important;
}

.card-des:hover {
	background-color: #e2e2e2;
	cursor: pointer;
}
</style>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<div class="container-fluid">
		<div class="row mt-3 ml-2">

			<%
				String cate = request.getParameter("cate");
				ProductDao pdao = new ProductDao(FactoryProvider.getFactory());
				List<Product> plist = null;
				if (cate == null) {
					plist = pdao.getProducts();
				} else if (cate.trim().equals("all")) {
					plist = pdao.getProducts();
					for (Product p : plist) {
					}
				} else {
					int cid = Integer.parseInt(cate.trim());
					plist = pdao.getAllProductsById(cid);
				}

				CategoryDao cdao = new CategoryDao(FactoryProvider.getFactory());
				List<Category> clist = cdao.getCategories();
			%>

			<!-- category div -->
			<div class="col-md-2">
				<div class="list-group mt-4">
					<a href="index.jsp?cate=all"
						class="list-group-item list-group-item-action active">All
						Products</a>
					<%
						for (Category c : clist) {
					%>
					<a href="index.jsp?cate=<%=c.getCategoryId()%>"
						class="list-group-item list-group-item-action"><%=c.getCategoryTitle()%></a>
					<%
						}
					%>

				</div>

			</div>

			<!-- product div -->
			<div class="col-md-10">
				<div class="row mt-4">
					<div class="col-md-12">
						<div class="card-columns">
							<!-- traversing products -->
							<%
								for (Product p : plist) {
							%>
							<div class="card card-des">
								<div class="container text-center">
									<img src="img/productimages/<%=p.getpPhoto()%>"
										class="card-img-top m-2"
										style="max-height: 200px; max-width: 100%; width: auto;">
								</div>
								<div class="card-body">
									<div class="card-title">
										<h5><%=p.getpName()%></h5>
										<p class="card-desc">
											<%=Helper.get10Words(p.getpDesc())%>
										</p>
									</div>
								</div>
								<div class="card-footer">
									<button class="btn custom-bg text-white" onclick="add_to_cart(<%=p.getpID()%>, '<%=p.getpName()%>', <%=p.getDiscountedPrice()%>)">Add to cart</button>
									<button class="btn btn-outline-success">
										&#8377;
										<%=p.getDiscountedPrice()%><span
											class="text-secondary discount-label"> &#8377;<%=p.getpPrice()%>-<%=p.getpDiscount()%>%
										</span>
									</button>
								</div>
							</div>

							<%
								}
								if (plist.size() == 0) {
									out.println("<h3>No Item in this category</h3>");
								}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
	<%@include file="components/common_modals.jsp" %>
</body>
</html>