
<%
	User user = (User) session.getAttribute("current_user");
	if (user == null) {
		session.setAttribute("message", "you are not logged in, login first to checkout");
		response.sendRedirect("login.jsp");
		return;
	}
%>



<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>
	<div class="container">
		<div class="row mt-5">
			<div class="col-md-6">
				<!-- card -->
				<div class="card">
					<div class="card-body">
						<h3 class="text-center mb-3">Your selected Items</h3>
						<div class="cart-body"></div>
					</div>
				</div>
			</div>
			<div class="col-md-6">
				<!-- form -->
				<div class="card">
					<div class="card-body">
						<h1 class="text-center mb-3">Your Details</h1>
						<form action="#!">
							<div class="form-group">
								<label for="exampleInputEmail1">Email address</label> <input
									type="email" value="<%=user.getUserEmail() %>" class="form-control" id="exampleInputEmail1"
									aria-describedby="emailHelp" placeholder="Enter email">
								<small id="emailHelp" class="form-text text-muted">We'll
									never share your email with anyone else.</small>
							</div>
							<div class="form-group">
								<label for="name">Shipping Name</label> <input type="text"
									class="form-control" value="<%=user.getUserName() %>" id="name" aria-describedby="emailHelp"
									placeholder="Enter name">
							</div>
							<div class="form-group">
								<label for="number">Contact Number</label> <input type="text"
									class="form-control" value="<%=user.getUserPhone() %>" id="phone" aria-describedby="emailHelp"
									placeholder="Enter name">
							</div>
							<div class="form-group">
								<label for="exampleFor mControlTextarea1">Shipping
									Address</label>
								<textarea value="<%=user.getUserAddress() %>" class="form-control" placeholder="Your Address Here"
									id="exampleFormControlTextarea1" rows="3"></textarea>
							</div>
							<div class="container text-center">
								<button class="btn btn-outline-success">Order now</button>
								<button class="btn btn-outline-primary">Continue
									Shopping</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<%@include file="components/common_modals.jsp"%>
</body>
</html>
