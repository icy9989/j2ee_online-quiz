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

<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
<script
	src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>
</head>
<style>
.section {
	position: relative;
}

.timer-containers {
	position: absolute;
	top: 0px;
	right: 5px;
}

.timerboxes {
	width: 50px;
	height: 50px;
	background-color: #3ad1f0;
	border-radius: 7px;
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
				<h5 class="d-inline text-white p-2">Quiz Answer</h5>
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
					<li class="nav-item"><a href="student-dashboard"
						class="nav-link mx-3">Dashboard</a></li>
				</ul>
				<form action="logout">
					<button type="submit" class="btn text-white justify-content-end">
						<i class="fas fa-sign-out"></i>
					</button>
				</form>
			</div>
		</nav>
	</header>

	<section class="section">
		<div class="col-sm-5 col-md-12 add-questions">
			<h2 class="mb-5 text-center textprimarys">
				<i class="fas fa-question-circle"></i>
				<%=request.getAttribute("courseId")%>
				-
				<%=request.getAttribute("testName")%></h2>
		</div>

		<c:set var="endTime" value="${testDate}" />

		<fmt:parseDate value="${endTime}" var="parsedEndTime"
			pattern="dd/MM/yyyy HH:mm:ss" />

		<input type="hidden" class="endtimes" value="${parsedEndTime}"
			class="form-control" />


		<div class="col-lg-2 timer-containers">
			<div class="row">
				<div class="col-3 py-2 text-center timerboxes">
					<h4 id="hours" class="text-white">00</h4>
				</div>
				<div class="col-1 py-2">
					<h4 class="text-info">:</h4>
				</div>
				<div class="col-3 py-2 text-center timerboxes">
					<h4 id="minutes" class="text-white">00</h4>
				</div>
				<div class="col-1 py-2">
					<h4 class="text-info">:</h4>
				</div>
				<div class="col-3 py-2 text-center timerboxes">
					<h4 id="seconds" class="text-white">00</h4>
				</div>
			</div>
		</div>

		<form id="myForm" name="myForm" action="quiz-answer-submit"
			method="post">
			<c:forEach var="q"
				items="<%=request.getAttribute(\"questionList\")%>" varStatus="i">
				<div class="col-11 mx-auto m-5">
					<div class="row">
						<div
							class="col-md-2 alert text-secondary b-alerts answer-markboxes">
							<p class="pb-3 fw-bold">Question No.${i.count}</p>
							<p>Mark - out of ${q.mark}</p>
						</div>

						<input type="hidden" name="qId-${i.count}" value="${q.id}" />

						<div
							class="center-block col-md-10 mx-auto card bordernones cardbgs">
							<div class="form-group m-2">
								<h5>${q.question_description }</h5>
							</div>
							<br>

							<div class="mx-2">
								<div class="my-2">
									<input type="radio" value="${q.option_one }"
										name="option-${q.id}"> ${q.option_one }
								</div>
								<div class="my-2">
									<input type="radio" value="${q.option_two }"
										name="option-${q.id}"> ${q.option_two }
								</div>
								<div class="my-2">
									<input type="radio" value="${q.option_three }"
										name="option-${q.id}"> ${q.option_three }
								</div>
								<div class="my-2">
									<input type="radio" value="${q.option_four }"
										name="option-${q.id}"> ${q.option_four }
								</div>
							</div>

							<input type="hidden" value="${q.answer }" name="ans-${i.count}"
								class="form-control"> <input type="hidden"
								name="mark-${i.count}" class="form-control" value="${q.mark}">

						</div>
					</div>
				</div>
			</c:forEach>

			<div class="mb-5 positioncenters">
				<button class="btn btns" type="submit" id="btn-submit">Submit</button>
			</div>

		</form>

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
	<script src="http://localhost:8080/online_quiz/js/answer-form.js"
		type="text/javascript"></script>

</body>
</html>