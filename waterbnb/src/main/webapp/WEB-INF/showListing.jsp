<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<link rel="stylesheet" type="text/css" href="/css/style.css">
		<title>WaterBnB | View Listing</title>
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
			<div class="col-2"></div>
			<div class="col-8 bg-grey-1 header">
				<h4>View Listing</h4>
			</div>
			<div class="col-2"></div>
		</div>
		<div class="row">
			<div class="col-2"></div>
			<div class="col-8 bg-white">
					<div class="col-6">
						<c:out value="${listing.address}"/>
						<textarea readonly class="full-w"><c:out value="${listing.description}"/></textarea>
						<input type="submit" class="btn-primary" value="Save Changes">
					</div>
					<div class="col-6">
						<table class="three-quarter-w">
							<tbody>
								<tr>
									<td>Email:</td>
									<td><c:out value="${listing.getUser().getEmail()}"/></td>
								</tr>
								<tr>
									<td>Name:</td>
									<td><c:out value="${listing.getUser().getFullName()}"/></td>
								</tr>
								<tr>
									<td>Pool Size:</td>
									<td><c:out value="${listing.getPoolSize()}"/></td>
								</tr>
								<tr>
									<td>Cost:</td>
									<td><c:out value="${listing.getCost()}"/> per night</td>
								</tr>
							</tbody>
						</table>
					</div>
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
				<a href='/pools/<c:out value="${listing.getId()}"/>/review' class="right">Leave Review</a>
				<div class="scroll">
					<c:forEach var="review" items="${listing.reviews}">
						<div class="col-12 content">
							<p>Name: <c:out value="${review.author.getFullName()}"/></p>
							<p>Rating: <c:out value="${review.rating}"/> / 5</p>
							<p><c:out value="${review.content}"/></p>
						</div>
					</c:forEach>
				</div>
			</div>
			<div class="col-2"></div>
		</div>
	</body>
</html>