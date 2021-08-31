<%@page import="java.util.Map"%>
<%@page import="helper.Helper"%>
<%@page import="entities.Category"%>
<%@page import="java.util.List"%>
<%@page import="helper.FactoryProvider"%>
<%@page import="dao.CategoryDao"%>
<%@page import="entities.User"%>
<%
	User user = (User) session.getAttribute("current_user");
	if (user == null) {
		session.setAttribute("message", "you are not logged in, login first");
		response.sendRedirect("login.jsp");
		return;
	} else {
		if (user.getUserType().equals("normal")) {
			session.setAttribute("message", "You are not an admin");
			response.sendRedirect("login.jsp");
			return;
		} else {

		}
	}
%>
<%
	CategoryDao categoryDao = new CategoryDao(FactoryProvider.getFactory());
	List<Category> cat = categoryDao.getCategories();
	
	Map<String, Long> m=Helper.getCount(FactoryProvider.getFactory());
%>


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<%@include file="components/common_css_js.jsp"%>
<style type="text/css">
.admin .card {
	border: 1px solid #673ab7;
}

.admin .card:hover {
	background-color: #e2e2e2;
	cursor: pointer;
}
</style>

<meta charset="ISO-8859-1">
<title>Admin Panel</title>
</head>


<body>
	<%@include file="components/navbar.jsp"%>
	<div class="container admin">
		<div class="container-fluid mt-3">
			<%@include file="components/message.jsp"%>
		</div>
		<div class="row mt-3">


			<!-- first box -->
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" src="img/users.png"
								style="max-width: 125px">
						</div>
						<h1><%= m.get("userCount") %></h1>
						<h1 class="text-uppercase text-muted">Users</h1>
					</div>
				</div>
			</div>


			<!-- second box -->
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" src="img/list.png"
								style="max-width: 125px">
						</div>
						<h1><%= cat.size() %></h1>
						<h1 class="text-uppercase text-muted">Categories</h1>
					</div>
				</div>
			</div>


			<!-- third box -->
			<div class="col-md-4">
				<div class="card">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" src="img/product.png"
								style="max-width: 125px">
						</div>
						<h1><%= m.get("productCount") %></h1>
						<h1 class="text-uppercase text-muted">Products</h1>
					</div>
				</div>
			</div>
		</div>


		<!-- second row -->
		<div class="row mt-3">
			<!-- first box -->
			<div class="col-md-6">


				<div class="card" data-toggle="modal"
					data-target="#add-category-modal">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" src="img/add_cate.png"
								style="max-width: 125px">
						</div>
						<p class="mt-2">Click here to add new Category</p>
						<h1 class="text-uppercase text-muted">Add Category</h1>
					</div>
				</div>
			</div>

			<!-- second box -->
			<div class="col-md-6">
				<div class="card" data-toggle="modal"
					data-target="#add-product-modal">
					<div class="card-body text-center">
						<div class="container">
							<img class="img-fluid rounded-circle" src="img/plus.png"
								style="max-width: 125px">
						</div>
						<p class="mt-2">Click here to add new Product</p>
						<h1 class="text-uppercase text-muted">Add Products</h1>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- add category modal -->
	<div class="modal fade" id="add-category-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header custom-bg text-white">
					<h5 class="modal-title" id="exampleModalLabel">Fill Category
						Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationsServlet" method="post">
						<input type="hidden" name="operation" value="addcategory">
						<div class="form-group">
							<input type="text" class="form-control" name=catTitle
								placeholder="Category name" required="required" />
						</div>
						<div class="form-group">
							<textarea style="height: 250px" class="form-control"
								placeholder="Category Description" name="catDesc"
								required="required"></textarea>
						</div>
						<div class="container text-center">
							<button class="btn btn-outline-success">Add Category</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- end category modal -->


	<!--add product modal -->
	<div class="modal fade" id="add-product-modal" tabindex="-1"
		role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog modal-lg" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Product Details</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="ProductOperationsServlet" method="post"
						enctype="multipart/form-data">
						<input type="hidden" name="operation" value="addproduct">
						<div class="form-group">
							<input type="text" class="form-control"
								placeholder="Product Title" name="pName" required="required">
						</div>
						<div class="form-group">
							<textarea class="form-control" placeholder="Product Description"
								name="pDesc" style="height: 150px"></textarea>
						</div>
						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Product Price" name="pPrice" required="required">
						</div>
						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Product Product Discount" name="pDiscount"
								required="required">
						</div>
						<div class="form-group">
							<input type="number" class="form-control"
								placeholder="Enter Product Quantity" name="pQuantity"
								required="required">
						</div>
						<div class="form-group">
							<select class="form-control" name="catId" id="">
								<%
									for (Category c : cat) {
								%>
								<option class="form-control" value="<%=c.getCategoryId()%>"><%=c.getCategoryTitle()%>
								</option>
								<%
									}
								%>
							</select>
						</div>
						<div class="form-group">
							<label for="pPhoto">Image of the product : </label> <input
								type="file" name="pPhoto" required="required">
						</div>
						<div class="form-group text-center">
							<button type="submit" class="btn btn-primary">Add
								Product</button>
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	<!-- end product modal -->
</body>
</html>




