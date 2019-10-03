<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="/css/style.css">
		<title>WaterBnB | Edit Listing</title>
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
				<h4>Edit Listing</h4>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 bg-white">
				<form:form action="/host/update/${listing.id}" method="post" modelAttribute="listing">
					<div class="col-6">
						<form:label path="address"> <form:errors path="address"/>
						<form:input path="address" value="${listing.address}" class="full-w"/></form:label>
						<form:hidden path="id"/>
						<form:textarea path="description" class="full-w"/>
						<input type="submit" class="btn-primary" value="Save Changes">
					</div>
					<div class="col-6">
						<table class="three-quarter-w">
							<tbody>
								<tr>
									<td>Email:</td>
									<td><c:out value="${listing.user.email}"/></td>
								</tr>
								<tr>
									<td>Name:</td>
									<td><c:out value="${listing.user.getFullName()}"/></td>
								</tr>
								<tr>
									<td>Pool Size:</td>
									<td><form:select path="poolSize" class="full-w">
										<c:forEach var="size" items="${poolSizes}">
											<form:option value="${size}" label="${size}"/>
										</c:forEach>
									</form:select></td>
								</tr>
								<tr>
									<td>Cost:</td>
									<td><form:select path="cost" class="full-w">
										<c:forEach var="num" begin="1" end="20">
											<form:option value="${num}0.00" label="${num}0.00"/>
										</c:forEach>
									</form:select></td>
								</tr>
							</tbody>
						</table>
					</div>
				</form:form>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 bg-white">
				<c:set var="averageRating" value="${0}"/>
				<c:forEach var="review" items="${listing.reviews}">
					<c:set var="averageRating" value="${averageRating + review.rating}"/>
				</c:forEach>
				<h4>Reviews (<c:out value="${averageRating / listing.reviews.size()}"/> / 5)</h4>
				<div class="scroll">
					<c:forEach var="review" items="${listing.reviews}">
						<div class="col-12 content">
							<p><c:out value="${review.author.getFullName()}"/></p>
							<p><c:out value="${review.rating}"/> / 5</p>
							<p><c:out value="${review.content}"/></p>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</body>
</html>