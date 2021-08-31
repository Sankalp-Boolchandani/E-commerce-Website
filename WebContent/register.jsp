<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>New User</title>
<%@include file="components/common_css_js.jsp"%>
</head>
<body>
	<%@include file="components/navbar.jsp"%>

	<div class="container-fluid">
		<div class="row mt-5">
			<div class="col-md-4 offset-md-4">
				<div class="card">
				<%@include file="components/message.jsp" %>
					<div class="card-body px-5">
						<div class="container text-center">
							<img src="img/registration.png" height="200px" width="200px">
						</div>
						<h3 class="text-center my3">Sign up here</h3>
						<form action="RegisterServlet" method="post">

							<div class="form-group">
								<label for="name">Username</label> <input type="text" name="username"
									class="form-control" id="name" aria-describedby="emailHelp"
									placeholder="Enter username">
							</div>
							<div class="form-group">
								<label for="email">Email</label> <input type="email" name="useremail"
									class="form-control" id="email" aria-describedby="emailHelp"
									placeholder="Enter Email">
							</div>
							<div class="form-group">
								<label for="password">Password</label> <input type="password" name="user_pass"
									class="form-control" id="password" aria-describedby="emailHelp"
									placeholder="Enter Password">
							</div>
							<div class="form-group">
								<label for="phone">Phone</label> <input type="number" name="user_phone"
									class="form-control" id="phone" placeholder="Enter Phone">
							</div>
							<div class="form-group">
								<label for="phone">Address</label>
								<textarea style="height: 200px" class="form-control" name="user_add"
									placeholder="Enter your Address"></textarea>
							</div>
							<div class="container text-center">
								<button class="btn btn-outline-success">Register</button>
								<button class="btn btn-outline-warning">Reset</button>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>