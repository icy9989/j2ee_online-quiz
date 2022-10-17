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

<!--timepicker -->
<link rel="stylesheet"
	href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
<script
	src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
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
				<h5 class="d-inline text-white p-2">Quiz Review</h5>
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

		<c:choose>
			<c:when test="${role == 'Instructor' }">
				<button class="btn btns btn-sm margin-right mb-3 mx-4 backbtns" type="button"
					name="back" onclick="history.back()">
					<i class="fas fa-arrow-alt-circle-left"></i> Back
				</button>
			</c:when>
			<c:otherwise>
				<a href="quiz-view?id=${c_quiz.id }&std_id=${user_id}"
					class="btn btns btn-sm margin-right mb-3 mx-4 backbtns"
					type="button" name="back"> <i
					class="fas fa-arrow-alt-circle-left"></i> Back
				</a>
			</c:otherwise>
		</c:choose>

		<div>
			<h2 class="mb-5 text-center textprimarys">
				<i class="fas fa-question-circle"></i>
				<%=request.getAttribute("courseId")%>
				-
				<%=request.getAttribute("testName")%></h2>
		</div>

		<div
			class="mx-5 text-center center-block col-sm-11 col-md-9 mx-auto card cardborders cardbgs">
			<div class="row justify-content-between">
				<div class="col-sm-12 col-xl-6">
					<div class="row">
						<div class="col-6">
							<p class="fw-bold text-start px-5 textsecondarys">Started on:</p>
							<p class="fw-bold text-start px-5 textsecondarys">State:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Total
								marks:</p>
						</div>
						<div class="col-6">
							<c:choose>
								<c:when test="${start_time != ''}">
									<p class="fw-bold text-start textsecondarys"><%=session.getAttribute("start_time")%></p>
								</c:when>
								<c:otherwise>
									<p class="fw-bold text-start textsecondarys">-</p>
								</c:otherwise>
							</c:choose>
							<p class="fw-bold text-start textsecondarys">Finished</p>
							<p class="fw-bold text-start textsecondarys"><%=session.getAttribute("user_mark")%></p>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-xl-6">
					<div class="row">
						<div class="col-6">
							<p class="fw-bold text-start px-5 textsecondarys">Completed
								on:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Time taken:</p>
							<p class="fw-bold text-start px-5 textsecondarys">Grade:</p>
						</div>
						<div class="col-6">
							<c:choose>
								<c:when test="${submit_time != ''}">
									<p class="fw-bold text-start textsecondarys"><%=session.getAttribute("submit_time")%></p>
								</c:when>
								<c:otherwise>
									<p class="fw-bold text-start textsecondarys">-</p>
								</c:otherwise>
							</c:choose>

							<c:set var="startTime" value="${start_time}" />
							<fmt:parseDate value="${start_time}" var="parsedStart_time"
								pattern="dd/MM/yyyy HH:mm:ss" />
							<c:set var="submitTime" value="${submit_time}" />
							<fmt:parseDate value="${submit_time}" var="parsedSubmit_time"
								pattern="dd/MM/yyyy HH:mm:ss" />
							<c:set var="timeTaken"
								value="${(parsedSubmit_time.time - parsedStart_time.time) / 1000}" />
							<c:set var="timeTaken1" value="${Double.parseDouble(timeTaken)}" />
							<c:choose>
								<c:when test="${timeTaken1 < 60}">
									<fmt:parseNumber var="timeTaken2" integerOnly="true"
										type="number" value="${timeTaken1}" />
									<p class="fw-bold text-start textsecondarys">${timeTaken2}s</p>
								</c:when>
								<c:otherwise>
									<c:choose>
										<c:when test="${timeTaken1 < 3600}">
											<c:set var="timeTaken3" value="${timeTaken1/60}" />
											<fmt:parseNumber var="timeTaken4" integerOnly="true"
												type="number" value="${timeTaken3}" />
											<c:set var="timeTaken5" value="${timeTaken3 - timeTaken4}" />
											<c:set var="timeTaken6" value="${timeTaken5 * 60}" />
											<fmt:parseNumber var="timeTaken7" integerOnly="true"
												type="number" value="${timeTaken6}" />
											<p class="fw-bold text-start textsecondarys">${timeTaken4}min
												${timeTaken7}s</p>
										</c:when>
										<c:otherwise>
											<c:set var="timeTaken8" value="${timeTaken1/3600}" />
											<fmt:parseNumber var="timeTaken9" integerOnly="true"
												type="number" value="${timeTaken8}" />
											<c:set var="timeTaken10" value="${timeTaken8 - timeTaken9}" />
											<c:set var="timeTaken11" value="${timeTaken10 * 3600}" />
											<fmt:parseNumber var="timeTaken12" integerOnly="true"
												type="number" value="${timeTaken11}" />

											<c:choose>
												<c:when test="${timeTaken12 > 60}">
													<c:set var="timeTaken13" value="${timeTaken12/60}" />
													<fmt:parseNumber var="timeTaken14" integerOnly="true"
														type="number" value="${timeTaken13}" />
													<c:set var="timeTaken15"
														value="${timeTaken13 - timeTaken14}" />
													<c:set var="timeTaken16" value="${timeTaken15 * 60}" />
													<fmt:parseNumber var="timeTaken17" integerOnly="true"
														type="number" value="${timeTaken16}" />

													<p class="fw-bold text-start textsecondarys">${timeTaken9}hr
														${timeTaken14}min ${timeTaken17}s</p>
												</c:when>
												<c:otherwise>
													<p class="fw-bold text-start textsecondarys">${timeTaken9}hr
														0min ${timeTaken12}s</p>
												</c:otherwise>
											</c:choose>
										</c:otherwise>
									</c:choose>
								</c:otherwise>
							</c:choose>
							<%
							float result = ((Float) session.getAttribute("user_mark") / (Float) session.getAttribute("total_mark")) * 100;
							System.out.println(result);
							request.setAttribute("a", result);
							%>
							<fmt:formatNumber var="result1" type="number"
								maxFractionDigits="2" value="${a}" />
							<p class="fw-bold text-start textsecondarys">${user_mark }
								out of ${total_mark} (${result1}%)</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<c:forEach var="q" items="<%=request.getAttribute(\"questionList\")%>"
		varStatus="i">

		<div class="col-11 mx-auto m-5">
			<div class="row">
				<div class="col-sm-2 alert text-secondary b-alerts answer-markboxes">
					<p class="pb-3 fw-bold">Question No.${i.count}</p>
					<c:choose>
						<c:when test="${ user_selected_option[i.index] == q.answer }">
							<p>
								<i class="fas fa-check text-success"></i><span
									class=" text-secondary"> Correct</span>
							</p>
							<p>Mark ${q.mark} out of ${q.mark}</p>
						</c:when>
						<c:otherwise>
							<p>
								<i class="fas fa-times text-danger"></i><span
									class=" text-secondary"> Incorrect</span>
							</p>
							<p>Mark 0 out of ${q.mark}</p>
						</c:otherwise>
					</c:choose>
				</div>

				<input type="hidden" name="qId-${i.count}" value="${q.id}" />

				<div class="col-sm-8 col-xl-10 mx-auto card bordernones cardbgs">
					<div class="form-group m-2">
						<h5>${q.question_description }</h5>
					</div>
					<br>

					<div class="mx-2">
						<div class="my-2">
							<c:choose>
								<c:when test="${q.option_one == user_selected_option[i.index]}">
									<input type="radio" value="${q.option_one }"
										name="option-${q.id}" disabled="disabled" checked="checked">  ${q.option_one }
								</c:when>
								<c:otherwise>
									<input type="radio" value="${q.option_one }"
										name="option-${q.id}" disabled="disabled">  ${q.option_one }
								</c:otherwise>
							</c:choose>
						</div>
						<div class="my-2">
							<c:choose>
								<c:when test="${q.option_two == user_selected_option[i.index]}">
									<input type="radio" value="${q.option_two }"
										name="option-${q.id}" disabled="disabled" checked="checked">  ${q.option_two }
								</c:when>
								<c:otherwise>
									<input type="radio" value="${q.option_two }"
										name="option-${q.id}" disabled="disabled">  ${q.option_two }
								</c:otherwise>
							</c:choose>
						</div>
						<div class="my-2">
							<c:choose>
								<c:when
									test="${q.option_three == user_selected_option[i.index]}">
									<input type="radio" value="${q.option_three }"
										name="option-${q.id}" disabled="disabled" checked="checked"> ${q.option_three}
								</c:when>
								<c:otherwise>
									<input type="radio" value="${q.option_three }"
										name="option-${q.id}" disabled="disabled"> ${q.option_three }
								</c:otherwise>
							</c:choose>
						</div>
						<div class="my-2">
							<c:choose>
								<c:when test="${q.option_four == user_selected_option[i.index]}">
									<input type="radio" value="${q.option_four }"
										name="option-${q.id}" disabled="disabled" checked="checked"> ${q.option_four }
								</c:when>
								<c:otherwise>
									<input type="radio" value="${q.option_four }"
										name="option-${q.id}" disabled="disabled"> ${q.option_four }
								</c:otherwise>
							</c:choose>
						</div>

					</div>


					<c:choose>
						<c:when test="${ user_selected_option[i.index] == q.answer }">
							<div class="alert g-alerts mt-2">
								<span class="text-dark">Your answer is correct. <br />
									The correct answer is ${q.answer }.
								</span>
							</div>
						</c:when>
						<c:otherwise>
							<div class="alert alert-danger mt-2">
								<span class="text-dark">Your answer is incorrect. <br />
									The correct answer is ${q.answer }.
								</span>
							</div>
						</c:otherwise>
					</c:choose>

					<input type="hidden" value="Correct Answer : ${q.answer }"
						name="ans-${i.count}" class="form-control"> <input
						type="hidden" name="mark-${i.count}" class="form-control"
						value="${q.mark}">

				</div>
			</div>
		</div>

	</c:forEach>

	<script type="text/javascript">
		const card = document.querySelector('.cardbgs');
		window.addEventListener("resize", resizeListener);

		function resizeListener() {
			let val = window.innerWidth;
			if (val < 689) {
				card.classList.replace('col-sm-9', 'col-sm-8');
			}
		}
	</script>


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

</body>
</html>