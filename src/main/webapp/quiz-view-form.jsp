<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
<link href="http://localhost:8080/online_quiz/css/style.css"
	rel="stylesheet" type="text/css">
<link href="http://localhost:8080/online_quiz/css/custom_card.css"
	rel="stylesheet" type="text/css">

</head>

<body>

	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>

	<header>
		<nav class="navbar navbar-expand-md mb-4">
			<a class="navbar-brand" href="admin-dashboard"> <img
				src="http://localhost:8080/online_quiz/img/logo.png" width="40"
				height="30" class="d-inline-block align-top" alt="">
				<h5 class="d-inline text-white p-2">Quiz View</h5>
			</a>

			<button class="navbar-toggler text-white togglers"
				data-bs-toggle="collapse" data-bs-target="#navbarcollapse">
				<div class="bars barones"></div>
				<div class="bars bartwos"></div>
				<div class="bars barthrees"></div>
			</button>

			<div id="navbarcollapse"
				class="navbar-collapse collapse justify-content-end">
				<c:choose>
					<c:when test="${role == 'Instructor' }">
						<ul class="navbar-nav">
							<li class="nav-item"><a href="instructor-dashboard"
								class="nav-link mx-3">Dashboard</a></li>
							<li class="nav-item"><a href="instructor-dashboard"
								class="nav-link mx-3 stds">Students</a></li>
							<li class="nav-item"><a href="instructor-dashboard"
								class="nav-link mx-3 cos">Courses</a></li>
						</ul>
					</c:when>
					<c:otherwise>
						<ul class="navbar-nav">
							<li class="nav-item"><a href="student-dashboard"
								class="nav-link mx-3">Dashboard</a></li>
						</ul>
					</c:otherwise>
				</c:choose>

				<form action="logout">
					<button type="submit" class="btn text-white justify-content-end">
						<i class="fas fa-sign-out"></i>
					</button>
				</form>
			</div>
		</nav>
	</header>

	<section>

		<div>
			<h2 class="mb-5 text-center textprimarys">
				<i class="fas fa-question-circle"></i> ${c_quiz.name }
			</h2>
		</div>

		<div
			class="mx-5 text-center center-block col-sm-11 col-md-9 mx-auto card cardborders cardbgs">
			<div class="row justify-content-between">
				<div class="col-sm-12 col-xl-6">
					<div class="row">
						<div class="col-6">
							<p class="fw-bold text-start px-5 textsecondarys">Date :</p>
							<p class="fw-bold text-start px-5 textsecondarys">Start Time:</p>
						</div>
						<div class="col-6">
							<p class="fw-bold text-start textsecondarys">${c_quiz.date }</p>
							<p class="fw-bold text-start textsecondarys">${c_quiz.startTime }</p>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-xl-6">
					<div class="row">
						<div class="col-6">
							<p class="fw-bold text-start px-5 textsecondarys">Duration:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Weightage:</p>
						</div>
						<div class="col-6">
							<p class="fw-bold text-start textsecondarys">${c_quiz.duration }
								minutes</p>
							<p class="fw-bold text-start textsecondarys">${c_quiz.total_mark }
								marks</p>
						</div>
					</div>
				</div>
			</div>
		</div>

		<jsp:useBean id="now" class="java.util.Date" />

		<c:set var="endTime" value="${testDate}" />

		<fmt:parseDate value="${endTime}" var="parsedEndTime"
			pattern="dd/MM/yyyy HH:mm:ss" />

		<c:set var="startTime" value="${testDate_startTime}" />

		<fmt:parseDate value="${startTime}" var="parsedStartTime"
			pattern="dd/MM/yyyy HH:mm:ss" />

		<c:choose>
			<c:when
				test="${c_quiz.published =='1' && parsedEndTime.time lt now.time}">

				<div class="bg-white m-5 px-3 col-md-9 mx-auto">
					<div class="table-responsive-lg">
						<table class="table m-2">
							<div
								class="d-flex justify-content-between align-items-center p-3">
								<h5 id="quote">Quiz Summary</h5>
							</div>

							<thead>
								<tr>
									<th>State</th>
									<th>Mark</th>
									<th>Review</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td><c:out value="Submitted" /></td>
									<td><c:out value="${user_mark} / ${c_quiz.total_mark}" /></td>
									<td><a href="quiz-review?id=${c_quiz.id}&uid=${uid}"><span
											class="badge bg-warning">view</span></a></td>
								</tr>
							</tbody>

						</table>
					</div>
				</div>

				<c:choose>
					<c:when test="${role == 'Instructor' }">
						<div class="m-5 positioncenters">
							<button class="btn btns btn-sm margin-right" type="button"
								name="back" onclick="history.back()">Back to the course</button>
						</div>
					</c:when>
					<c:otherwise>
						<div class="m-5 positioncenters">
							<a href="registered-course?name=${courseName}" class="btn btns"
								type="button">Back to the course</a>
						</div>
					</c:otherwise>
				</c:choose>



			</c:when>

			<c:otherwise>
				<c:choose>
					<c:when test="${c_quiz.published =='1'}">
						<c:choose>
							<c:when test="${parsedStartTime.time le now.time}">
								<c:choose>
									<c:when test="${submit_attempt != null}">
										<div class="bg-white m-5 px-3 col-md-9 mx-auto">
											<div class="table-responsive-lg">
												<table class="table m-2">
													<div
														class="d-flex justify-content-between align-items-center p-3">
														<h5 id="quote">Summary of your previous attempt</h5>
													</div>

													<thead>
														<tr>
															<th>State</th>
															<th>Mark</th>
															<th>Review</th>
														</tr>
													</thead>
													<tbody>
														<tr>
															<td><c:out value="Submitted" /></td>
															<td><c:out
																	value="${user_mark} / ${c_quiz.total_mark}" /></td>
															<td>-</td>
														</tr>
													</tbody>

												</table>
											</div>
										</div>

										<div class="alert alert alert-info col-md-9 mx-auto"
											role="alert">You can review the test after time's up</div>
										<div class="m-5 positioncenters">
											<a href="registered-course?name=${courseName}"
												class="btn btns" type="button">Back to the course</a>
										</div>

									</c:when>
									<c:otherwise>
										<div class="m-5 p-5 positioncenters">
											<a href="quiz-answer?id=<c:out value='${c_quiz.id}'/>"
												class="btn btns">Start Attempt</a>
										</div>
									</c:otherwise>
								</c:choose>
							</c:when>
							<c:otherwise>
								<div class="alert alert alert-danger col-md-9 mx-auto m-5"
									role="alert">
									<span>You cannot start attempt the exam</span>
									<!-- <span>The quiz is over! <br /> You cannot attempt
										anymore.
									</span> -->
								</div>
								<div class="m-5 positioncenters">
									<a href="registered-course?name=${courseName}" class="btn btns"
										type="button">Back to the course</a>
								</div>
							</c:otherwise>
						</c:choose>
					</c:when>
					<c:otherwise>
						<!-- <div class="alert alert alert-danger col-md-9 mx-auto m-5" role="alert">
<span>The quiz is over! <br/> You cannot attempt anymore.</span>
</div> -->
						<div class="alert alert alert-danger col-md-9 mx-auto m-5"
							role="alert">
							<span>You cannot attempt the exam.</span>
						</div>
						<div class="m-5 positioncenters">
							<a href="registered-course?name=${courseName}" class="btn btns"
								type="button">Back to the course</a>
						</div>
					</c:otherwise>
				</c:choose>

			</c:otherwise>
		</c:choose>

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
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		type="text/javascript"></script>

</body>
</html>
