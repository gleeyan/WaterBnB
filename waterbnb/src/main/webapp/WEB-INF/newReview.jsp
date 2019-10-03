<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="/css/style.css">
		<title>WaterBnB | View Listing</title>
	</head>
	<body>
		<div class="nav-bar bg-black">
			<table>
				<tbody>
					<tr>
						<td><form id="logoutForm" method="POST" action="/logout">
					        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
					        <input type="submit" value="Logout" class="btn-primary inline-nav stubborn"/>
					    </form></td>
						<td><a href="/"><button class="btn-primary">Home</button></a></td>
					</tr>
				</tbody>
			</table>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 bg-grey-1 header">
				<h4>Leave a Review</h4>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 bg-white">
				<p>Review of <c:out value="${listing.address}"/></p>
				<form:form path="/pools/${listing.id}/review" modelAttribute="review">
					<form:textarea path="content" class="three-quarter-w"/>
					<p><form:label path="rating">Rating <form:select path="rating">
						<c:forEach var="r" begin="1" end="5">
							<form:option value="${r}"/>
						</c:forEach>
					</form:select></form:label></p>
					<input type="submit" class="btn-primary" value="Leave Review">
				</form:form>
			</div>
			<div class="col-2"></div>
		</div>
	</body>
</html>