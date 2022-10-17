<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Quiz</title>
<!-- bootstrap css1 -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor"
	crossorigin="anonymous">
<!-- fontawesome css1 -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css"
	integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<!-- custom css -->
<link href="css/style.css" rel="stylesheet" type="text/css">
<link href="css/custom_card.css" rel="stylesheet" type="text/css">

<link rel="stylesheet"
	href="http://localhost:8080/online_quiz/css/style.css" type="text/css">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons"
	rel="stylesheet">
</head>

<style>
section {
	position: relative;
}

.backbtns {
	position: absolute;
	top: 0;
	left: 0;
}
</style>

<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>

	<header>
		<nav class="navbar navbar-expand-md mb-4">
			<a class="navbar-brand" href="admin-dashboard"> <img
				src="http://localhost:8080/online_quiz/img/logo.png" width="40"
				height="30" class="d-inline-block align-top" alt="">
				<h5 class="d-inline text-white p-2">Quiz Summary</h5>
			</a>

			<button class="navbar-toggler text-white togglers"
				data-bs-toggle="collapse" data-bs-target="#navbarcollapse">
				<div class="bars barones"></div>
				<div class="bars bartwos"></div>
				<div class="bars barthrees"></div>
			</button>

			<div id="navbarcollapse"
				class="navbar-collapse collapse justify-content-end">
				<ul class="navbar-nav">
					<li class="nav-item"><a href="instructor-dashboard"
						class="nav-link mx-3">Dashboard</a></li>
					<li class="nav-item"><a href="instructor-dashboard"
						class="nav-link mx-3 stds">Students</a></li>
					<li class="nav-item"><a href="instructor-dashboard"
						class="nav-link mx-3 cos">Courses</a></li>
				</ul>

				<form action="logout">
					<button type="submit" class="btn text-white justify-content-end">
						<i class="fas fa-sign-out"></i>
					</button>
				</form>
			</div>
		</nav>
	</header>

	<section>

		<button class="btn btns btn-sm margin-right mb-3 mx-4 backbtns"
			type="button" name="back" onclick="history.back()">
			<i class="fas fa-arrow-alt-circle-left"></i> Back
		</button>

		<div>
			<h2 class="mb-5 text-center textprimarys">
				<i class="fas fa-question-circle"></i> Quiz Summary
			</h2>
		</div>

		<div
			class="mx-5 text-center center-block col-sm-11 col-md-9 mx-auto card cardborders cardbgs">
			<div class="row justify-content-between">
				<div class="col-sm-12 col-xl-6">
					<div class="row">
						<div class="col-6">
							<p class="fw-bold text-start px-5 textsecondarys">Date:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Starting
								Time:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Duration:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Questions</p>
						</div>
						<div class="col-6">
							<p class="fw-bold text-start textsecondarys">${cq.date}</p>
							<p class="fw-bold text-start textsecondarys">${cq.startTime}</p>
							<p class="fw-bold text-start textsecondarys">${cq.duration}
								Minute</p>
							<p class="fw-bold text-start textsecondarys">${cq.total_question}</p>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-xl-6">
					<div class="row">
						<div class="col-6">
							<p class="fw-bold text-start px-5 textsecondarys">Total Mark:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Maximum:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Minimum:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Average:</p>
						</div>
						<div class="col-6">
							<p class="fw-bold text-start textsecondarys">${cq.total_mark }</p>
							<p class="fw-bold text-start textsecondarys">${maximum }</p>
							<p class="fw-bold text-start textsecondarys">${minimum }</p>
							<p class="fw-bold text-start textsecondarys">${average }</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="bg-white m-5 px-3 col-md-9 mx-auto">
			<div class="table-responsive-lg">
				<table id="myTable" class="table m-2">
					<div class="d-flex justify-content-between align-items-center p-3">
						<h5 id="quote">All Students' Marks</h5>
						<div class="col-xl-3 col-lg-4 col-md-5 col-sm-5 mb-4">
							<div class="input-group">
								<input type="search" name="search" id="search"
									onkeyup="tableSearch()"
									class="form-control form-control-sm rounded-0"
									placeholder="Search..." />
								<button type="button" onclick="tableSearch()"
									class="btn btn-sm btns">
									<i class="fas fa-search"></i>
								</button>
							</div>
						</div>
					</div>

					<thead>
						<tr>
							<th rowspan="1">NO</th>
							<th rowspan="2">NAME</th>
							<th rowspan="2">MARK</th>
							<th rowspan="2">RESULTS</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="s" items="${stdMarkList}" varStatus="i">
							<tr>
								<td><c:out value="${i.count}" /></td>
								<td><c:out value="${s.name}" /></td>
								<td><c:out value="${s.mark}" /></td>
								<td><a href="quiz-review?id=${cq.id }&uid=${s.id}"><span
										class="badge bg-warning">details</span></a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</section>



	<!-- bootstrap js2 -->
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js"
		integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js"
		integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy"
		crossorigin="anonymous"></script>
	<!-- jquery -->
	<script
		src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<!-- custom js -->
	<script src="js/user-list.js" type="text/javascript"></script>
</body>
</html>

