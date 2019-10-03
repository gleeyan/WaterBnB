<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="/css/style.css">
		<title>WaterBnB</title>
	</head>
	<body>
		<div class="nav-bar bg-black">
			<c:choose>
				<c:when test="${user != null}">
				<table>
					<tbody>
						<tr>
							<td><form id="logoutForm" method="POST" action="/logout">
						        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
						        <input type="submit" value="Logout" class="btn-primary inline-nav stubborn" />
						    </form></td>
							<td><a href="/"><button class="btn-primary">Home</button></a></td>
						</tr>
					</tbody>
				</table>
				</c:when>
				<c:otherwise>
					<table>
						<tbody>
							<tr>
								<td><a href="/guest/signin"><button class="btn-primary inline-nav stubborn">Login/Register</button></a></td>
							</tr>
						</tbody>
					</table>
				</c:otherwise>
			</c:choose>
		</div>
		<div class="row">
			<div class="col-3"></div>
			<div class="col-6 bg-white">
				<div class="header">
					<p>Find places to swim and sleep on WaterBnB!</p>
				</div>
				<form action="/search">
					<div class="center-text">
						<input type="text" class="three-quarter-w" placeholder="Enter a location here..." name="q">
						<input type="submit" class="btn-primary">
					</div>
				</form>
				<c:set var="averageRating" value="${0}"/>
				<c:forEach var="review" items="${listing.reviews}">
					<c:set var="averageRating" value="${averageRating + review.rating}"/>
				</c:forEach>
				<table class="center three-quarter-w">
					<thead>
						<th>Address</th>
						<th>Pool Size</th>
						<th>Cost Per Night</th>
						<th>Details</th>
					</thead>
					<tbody>
						<c:forEach var="l" items="${results}">
							<tr>
								<td><c:out value="${l.getAddress()}"/></td>
								<td><c:out value="${l.getPoolSize()}"/></td>
								<td><c:out value="${l.getCost()}"/></td>
								<c:set var="averageRating" value="${0}"/>
								<c:forEach var="review" items="${l.getReviews()}">
									<c:set var="averageRating" value="${averageRating + review.rating}"/>
								</c:forEach>
								<c:choose>
									<c:when test="${averageRating == 0}">
										<td><a href='/pools/<c:out value="${l.getId()}"/>'>No Ratings</a></td>								
									</c:when>
									<c:otherwise>
										<td><a href='/pools/<c:out value="${l.getId()}"/>'><c:out value="${averageRating / l.reviews.size()}"/> / 5</a></td>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="col-3"></div>
		</div>
	</body>
</html>