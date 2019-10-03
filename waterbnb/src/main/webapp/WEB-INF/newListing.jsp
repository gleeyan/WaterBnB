<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="/css/style.css">
		<title>WaterBnB | Host Dashboard</title>
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
			<h4>Current Listings</h4>
		</div>
		<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 bg-white">
				<table class="center three-quarter-w">
					<thead>
						<th>Address</th>
						<th>Pool Size</th>
						<th>Cost Per Night</th>
						<th>Details</th>
					</thead>
					<tbody>
						<c:forEach var="l" items="${allListings}">
							<tr>
								<td><c:out value="${l.address}"/></td>
								<td><c:out value="${l.poolSize}"/></td>
								<td><c:out value="${l.cost}"/></td>
								<c:set var="averageRating" value="${0}"/>
								<c:forEach var="review" items="${l.reviews}">
									<c:set var="averageRating" value="${averageRating + review.rating}"/>
								</c:forEach>
								<c:choose>
									<c:when test="${averageRating == 0}">
										<td><a href='/host/update/<c:out value="${l.getId()}"/>'>No Ratings - Edit</a></td>								
									</c:when>
									<c:otherwise>
										<td><a href='/host/update/<c:out value="${l.getId()}"/>'><c:out value="${averageRating / l.reviews.size()}"/> / 5 - Edit</a></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6 bg-grey-1 header">
				<h4>New Listing</h4>
			</div>
			<div class="col-3"></div>
		</div>
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6 bg-white">
				<form:form action="/host/create" method="post" modelAttribute="listing">
					<form:label path="address">Address <span class="error"><form:errors path="address"/></span>
					<form:input path="address" class="full-w"/></form:label>
					
					<form:label path="description">Description <span class="error"><form:errors path="description"/></span>
					<form:textarea path="description" class="full-w"/></form:label>
					
					<form:label path="cost">Cost Per Night($$) <span class="error"><form:errors path="cost"/></span>
					<form:select path="cost" class="full-w">
						<c:forEach var="num" begin="1" end="20">
							<form:option value="${num}0.00" label="${num}0.00"/>
						</c:forEach>
					</form:select></form:label>
					
					<form:label path="poolSize">Pool Size <span class="error"><form:errors path="poolSize"/></span>
					<form:select path="poolSize" class="full-w">
						<c:forEach var="size" items="${poolSizes}">
							<form:option value="${size}" label="${size}"/>
						</c:forEach>
					</form:select></form:label>
					
					<input type="submit" class="btn-primary" value="Create Listing">
				</form:form>
			</div>
			<div class="col-3"></div>
		</div>
	</body>
</html>