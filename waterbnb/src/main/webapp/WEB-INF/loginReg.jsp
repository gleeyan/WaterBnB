<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="/css/style.css">
		<title>WaterBnB</title>
	</head>
	<body>
		<div class="nav-bar bg-black">
			<table>
				<tbody>
					<tr>
						<td><a href="/"><button class="btn-primary inline-nav stubborn">Home</button></a></td>
						<td><c:if test="${logoutMessage != null}">
								<span class="text-white stubborn"><c:out value="${logoutMessage}"></c:out></span>
							</c:if></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="row">
		<div class="col-2"></div>
		<div class="col-3 bg-grey-1 header">
			<h4>Register a New Account</h4>
		</div>
		<div class="col-1"></div>
		<div class="col-3 bg-grey-1 header">
			<h4>Sign Into Existing Account</h4>
		</div>
		<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-3 bg-white">
				<form:form action="/register" method="POST" modelAttribute="user">
					<form:label path="firstName">First Name <span class="error"><form:errors path="firstName"/></span>
					<form:input path="firstName" class="full-w"/></form:label>
					
					<form:label path="lastName">Last Name <span class="error"><form:errors path="lastName"/></span>
					<form:input path="lastName" class="full-w"/></form:label>
					
					<form:label path="email">Email <span class="error"><form:errors path="email"/></span>
					<form:input path="email" class="full-w"/></form:label>
					
					<form:label path="password">Password <span class="error"><form:errors path="password"/></span>
					<form:input type="password" path="password" class="full-w"/></form:label>
					
					<form:label path="passwordConfirm">Confirm Password <span class="error"><form:errors path="passwordConfirm"/></span>
					<form:input type="password"  path="passwordConfirm" class="full-w"/></form:label>
					
					<label for="role">Account Type</label>
					<select name="role" class="full-w">
						<option value="Guest">Guest</option>
						<option value="Host">Host</option>
					</select>
					
					<input type="submit" value="Register" class="btn-primary">
				</form:form>
			</div>
			<div class="col-1"></div>
			<div class="col-3 bg-white">
			    <c:if test="${errorMessage != null}">
			        <c:out value="${errorMessage}"></c:out>
			    </c:if>
				<form action="/guest/signin" method="post">
				<label for="username">Username</label>
				<input type="text" class="full-w" name="username">
				
				<label for="username">Password</label>
				<input type="password" class="full-w" name="password">
				
				<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
				<input type="submit" value="Sign In" class="btn-primary">
				</form>
			</div>
			<div class="col-2"></div>
		</div>
	</body>
</html>