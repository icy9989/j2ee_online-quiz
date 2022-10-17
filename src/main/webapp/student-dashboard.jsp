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
<link href="http://localhost:8080/online_quiz/css/dashboard.css"
	rel="stylesheet" type="text/css">
</head>
<body>
	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<header>
		<!-- START NAVBAR -->
		<nav class="navbar navbar-expand-lg">

			<button class="navbar-toggler togglers" data-bs-toggle="collapse"
				data-bs-target="#mynavbar">
				<div class="bars barones"></div>
				<div class="bars bartwos"></div>
				<div class="bars barthrees"></div>
			</button>

			<div id="mynavbar" class="navbar-collapse collapse">
				<div class="container-fluid">
					<div class="row">
						<div class="col-xl-2 col-lg-3 col-md-5 fixed-top sidebars">

							<div class="profileboxes">
								<a data-bs-toggle="modal" data-bs-target="#changepw-modal"
									class="pw-edits"><i class="fas fa-pencil beigetexts"></i></a>
								<div class="mb-3 profileimgs">
									<h1 class="profiletexts textprimarys">${username}</h1>
								</div>
								<p class="fw-bold m-3 beigetexts">${username}</p>
							</div>

							<ul class="mt-5 lists">
								<li class="listitems dashboards actives"><a
									href="student-dashboard"><i class="fas fa-home mx-3"></i>Dashboard</a></li>
								<li class="listitems courses"><a href="#"><i
										class="fas fa-laptop-code mx-3"></i>Courses</a></li>
							</ul>

							<div class="positioncenters m-5">
								<a href="<%=request.getContextPath()%>"
									class="btn btn-info text-white btns">Log out</a>
							</div>

						</div>
					</div>
				</div>
			</div>
		</nav>
		<!-- END NAVBAR -->
	</header>

	<section class="container-fluid">
		<div class="row">

			<!-- Start Dashboard -->
			<div id="dashboard" class="col-xl-7 col-lg-5 col-sm-7 ms-auto p-4">
				<p class="fw-bold text-secondary text-uppercase">Dashboard</p>

				<c:if test="${passwordChangeDoneMsg != null}">
					<div class="alert g-alerts">
						<p class="text-secondary">
							<strong>Success!</strong> Successfully ${passwordChangeDoneMsg}
						</p>
					</div>
				</c:if>
				<c:if test="${passwordChangeFailedMsg != null}">
					<div class="alert alert-danger">
						<p class="text-secondary">
							<strong>Failed!</strong> ${passwordChangeFailedMsg}
						</p>
					</div>
				</c:if>

				<%
				// Removing after display
				session.removeAttribute("passwordChangeDoneMsg");
				session.removeAttribute("passwordChangeFailedMsg");
				%>
				<div class="row">

					<div class="col-xl-6 px-5 my-3">
						<div class="card px-4">
							<div class="card-body">
								<div class="d-flex justify-content-between align-items-center">
									<i class="fas fa-book fa-3x"></i>
									<div class="text-secondary">
										<h5>Courses</h5>
										<h5 class="pt-2">6</h5>
									</div>
								</div>
							</div>
						</div>
					</div>

				</div>
			</div>
			<!-- End Dashboard -->

			<!-- Start Course -->
			<div id="course" class="col-xl-7 col-lg-5 col-sm-7 ms-auto p-4">
				<p class="fw-bold text-secondary text-uppercase">Course</p>
				<div class="row">
					<c:forEach var="c"
						items="<%=session.getAttribute(\"student-course-list\")%>">
						<div class="col-xl-6 px-5 my-3 newcards">
							<a
								href="registered-course?name=<c:out value='${c.code} - ${c.courseName}' />">
								<div class="card px-4">
									<div class="card-body" data-toggle="tooltip" data-placement="top" title="${c.courseName}">
										<div class="d-flex justify-content-between align-items-center" >
											<i class="fas fa-book fa-3x"></i>
											<div class="text-secondary">
												<h5>${c.code}</h5>
												
												<h5 class="pt-2 display-courses" >${c.courseName}
												
												</h5>
											</div>
										</div>
										
									</div>
									
								</div>
							</a>
						</div>
					</c:forEach>

				</div>
			</div>
			<!-- End Course -->


			<!-- Start Calendar -->
			<div class="col-xl-3 col-lg-4 col-sm-5 p-5">
				<div class="calendarcards bg-white">
					<div class="daycards positioncenters">
						<p id="day" class="m-0 p-2 text-white"></p>
					</div>
					<div class="p-3 text-secondary datecards positioncenters">
						<p id="month" class="monthfonts"></p>
						<p class="datefonts">
							<span id="daydate"></span>
						</p>
					</div>
					<div class="p-1 yearcards positioncenters">
						<p id="year" class="m-0 p-2 text-white"></p>
					</div>
				</div>
			</div>
			<!-- End Calendar -->

		</div>
	</section>
	<!-- END SECTION -->

	<div id="changepw-modal" class="modal">
		<div class="modal-dialog modal-dialog-centered">
			<div class="modal-content">
				<div class="modal-header modal-headerbgs">
					<h4 class="modal-title text-white">
						<i class="fas fa-key"></i> Change Password
					</h4>
					<button class="btn text-white" data-bs-dismiss="modal">
						<i class="fas fa-close" style="font-size: 24px"></i>
					</button>
				</div>
				<div class="modal-body">
					<div>
						<form class="form-pwchanges" action="ChangePassword" method="post">
							<div class="p-3">
								<input type="hidden" name="user_id"
									value="<c:out value='${user_id}' />" /> <input type="hidden"
									name="role" value="<c:out value='${role}' />" />
								<div class="form-group row m-3">
									<label class="col-4 col-form-label text-center textprimarys">Old
										Password</label>
									<div class="col-8">
										<input type="password" name="old_pw"
											class="form-control text-secondary pwones" required /> <i
											class="fas fa-eye textprimarys eyes eyeiconones"></i>
									</div>
								</div>
								<div class="form-group row m-3">
									<label class="col-4 col-form-label text-center textprimarys">New
										Password</label>
									<div class="col-8">
										<input type="password" name="new_pw"
											class="form-control text-secondary pwtwos" required /> <i
											class="fas fa-eye textprimarys eyes eyeicontwos"></i>
									</div>
								</div>

							</div>

							<div class="d-flex justify-content-end px-5 mb-3">
								<button type="submit" class="btn btn-sm btns">Save</button>
							</div>
						</form>
					</div>
				</div>

			</div>
		</div>
	</div>
	<!-- End modal -->

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
	<!-- custom js -->
	<script src="http://localhost:8080/online_quiz/js/app.js"
		type="text/javascript"></script>
	<script src="http://localhost:8080/online_quiz/js/student-dashboard.js"
		type="text/javascript"></script>

</body>
</html>