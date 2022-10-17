<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="model.Quiz"%>
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

<script
	src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
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
			<a class="navbar-brand" href="instructor-dashboard"> <img
				src="http://localhost:8080/online_quiz/img/logo.png" width="40"
				height="30" class="d-inline-block align-top" alt="">
				<h5 class="d-inline text-white p-2">Quiz Details</h5>
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
				<i class="fas fa-question-circle"></i> Quiz Details
			</h2>
		</div>

		<form action="update-quiz" method="post">
			<div
				class="mx-5 text-center center-block col-sm-11 col-md-9 mx-auto card cardborders cardbgs">
				<div class="row justify-content-between">
					<div class="col-lg-10">

						<input type="hidden" name="id"
							value="<%=request.getAttribute("id")%>" />

						<div class="row">
							<div class="col-6">
								<div class="row">
									<div class="col-4">
										<p class="fw-bold py-2 text-end textsecondarys">Name</p>
									</div>
									<div class="col-8">
										<input type="text" class="form-control text-secondary"
											value="<%=request.getAttribute("name")%>" name="name"
											id="name" required /> <small id="name_err"
											style="color: red;"></small>
									</div>
									<small id="date_err" style="color: red;"></small>
								</div>
							</div>
							<div class="col-6">
								<div class="row">
									<div class="col-4">
										<p class="fw-bold text-end py-2 textsecondarys">Date</p>
									</div>
									<div class="col-8">
										<input type="text" class="date form-control text-secondary"
											value="<%=request.getAttribute("date")%>" name="date"
											id="date" required /> <small id="date_err"
											style="color: red;"></small>
									</div>
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-6">
								<div class="row">
									<div class="col-4">
										<p class="fw-bold text-end py-2 textsecondarys">Start Time</p>
									</div>
									<div class="col-8">
										<input type="text"
											value="<%=request.getAttribute("start_time")%>"
											class="form-control" name="stime" id="datetime"
											autocomplete="off" required /> <small id="stime_err"
											style="color: red;"></small>
									</div>
								</div>
							</div>
							<div class="col-6">
								<div class="row">
									<div class="col-4">
										<p class="fw-bold text-end py-2 textsecondarys">Duration</p>
									</div>
									<div class="col-8">
										<input type="text"
											value="<%=request.getAttribute("duration")%>"
											class="form-control" name="duration" id="duration" required />
										<small id="stime_err" style="color: red;"></small>
									</div>
								</div>
							</div>

						</div>

						<input type="hidden"
							value="<%=request.getAttribute("total_question")%>"
							class="form-control" name="questions">

						<div class="row">
							<div class="col-6">
								<div class="row">
									<div class="col-4">
										<p class="fw-bold text-end py-2 textsecondarys">Published
										</p>
									</div>
									<div class="col-8">
										<div class="row py-2">
											<c:choose>
												<c:when test="${published == \"0\" }">
													<div class="col-6">
														<input type="radio" id="Netflix" name="published"
															value="1"> <label>Yes</label>
													</div>
													<div class="col-6">
														<input type="radio" id="Netflix" name="published"
															value="0" checked="checked"> <label>No</label>
													</div>
												</c:when>
												<c:otherwise>
													<div class="col-6">
														<input type="radio" id="Netflix" name="published"
															value="1" checked="checked"> <label>Yes</label>
													</div>
													<div class="col-6">
														<input type="radio" id="Netflix" name="published"
															value="0"> <label>No</label>
													</div>
												</c:otherwise>
											</c:choose>
										</div>
									</div>

								</div>
							</div>
						</div>

					</div>
				</div>
			</div>

			<c:forEach var="q" items="<%=request.getAttribute(\"qList\")%>"
				varStatus="i">
				<div
					class="mx-5 center-block col-sm-11 col-md-9 mx-auto m-5 card bordernones cardbgs">
					<div class="form-group col-md-3">
						<h5 class="pb-3 textsecondarys">Question No.${i.count}</h5>
					</div>

					<input type="hidden" name="qId-${i.count}" value="${q.id }" />

					<div class="form-group">
						<textarea class="form-control text-secondary"
							id="exampleFormControlTextarea1" rows="2" placeholder="Question"
							name="q-${i.count}" required>${q.question_description }</textarea>
					</div>
					<br>

					<div class="row">
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(i.index*4)+1}" value="${q.option_one }"
								placeholder="Option 1" required />
						</div>
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(i.index*4)+2}" value="${q.option_two }"
								placeholder="Option 2" required />
						</div>
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(i.index*4)+3}" value="${q.option_three }"
								placeholder="Option 3" required />
						</div>
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(i.index*4)+4}" value="${q.option_four }"
								placeholder="Option 4" required />
						</div>
					</div>

					<div class="row">
						<div class="form-group col-sm-6 col-lg-3 mb-3">
							<input type="text" class="form-control text-secondary"
								name="ans-${i.count}" value="${q.answer }" placeholder="Answer"
								required />
						</div>
						<div class="form-group col-sm-6 col-lg-3">
							<input type="text" class="form-control text-secondary"
								name="mark-${i.count}" value="${q.mark}" placeholder="Mark"
								required />
						</div>
					</div>
				</div>
			</c:forEach>

			<div class="positioncenters">
				<a href="delete-quiz?id=<%=request.getAttribute("id")%>"
					class="btn text-white mb-3 mx-3 btns" role="button"
					onclick="confirmation(this)">Delete</a>
				<button type="submit" class="btn text-white mb-3 mx-3 btns"
					onclick="return quizFormValidate()">Save</button>
			</div>

		</form>

	</section>

	<script>
		function quizFormValidate() {
			var valid = true;

			const emptyField = "*field is empty*";

			if (document.getElementById("name").value == "") {
				document.getElementById("name_err").innerHTML = emptyField;
				valid = false;
			}

			else {
				document.getElementById("name_err").innerHTML = "";
			}

			if (document.getElementById("datetime").value == "") {
				document.getElementById("stime_err").innerHTML = emptyField;
				valid = false;
			}

			else {
				document.getElementById("stime_err").innerHTML = "";
			}

			if (document.getElementById("date").value == "") {
				document.getElementById("date_err").innerHTML = emptyField;
				valid = false;
			}

			else {
				document.getElementById("date_err").innerHTML = "";
			}

			if (document.getElementById("duration").value == "") {
				document.getElementById("duration_err").innerHTML = emptyField;
				valid = false;
			}

			else {
				document.getElementById("duration_err").innerHTML = "";
			}
			return valid;
		}
	</script>
	<script>
		$('#datetime').timepicker({
			timeFormat : 'h:mm p',
			minTime : '9',
			interval : '60',
			maxTime : '5:00pm',
			startTime : '9:00',
			defaultTime : '0'
		});
	</script>
	<script type="text/javascript">
		var dateToday = new Date();

		$('#date').datepicker({
			numberOfMonths : 1,
			dateFormat : "dd/mm/yy",
			minDate : 0,
			maxDate : '10D'
		});

		function confirmation(button) {
			//getting href value
			var href = button.getAttribute("id");
			console.log(href);
			var result = confirm("Are you sure you want to do this?");

			if (result) {
				//if click yes redirect 
				window.location.href = href;
			} else {

				return false;
			}
		}

		setTimeout(function() {

			// Closing the alert
			$('.alert').alert('close');
		}, 5000);
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

