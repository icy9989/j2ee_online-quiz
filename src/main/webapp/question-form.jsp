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
				<h5 class="d-inline text-white p-2">Question Form</h5>
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
					<li class="nav-item"><a href="admin-dashboard"
						class="nav-link mx-3">Dashboard</a></li>
					<li class="nav-item"><a href="student" class="nav-link mx-3">Students</a></li>
					<li class="nav-item"><a href="courses" class="nav-link mx-3">Courses</a></li>
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

		<button class="btn btns btn-sm margin-right mb-3 mx-4 backbtns" type="button"
			name="back" onclick="history.back()">
			<i class="fas fa-arrow-alt-circle-left"></i> Back
		</button>

		<div>
			<h2 class="mb-5 text-center textprimarys">
				<i class="fas fa-plus"></i> Add Questions
			</h2>
		</div>

		<form action="insert-quiz" method="post">
			<c:forEach items="<%=request.getAttribute(\"total_question\")%>"
				var="q" varStatus="loop">
				<div
					class="mx-5 center-block col-sm-11 col-md-9 mx-auto m-5 card bordernones cardbgs">
					<div class="form-group col-md-3">
						<h5 class="pb-3 textsecondarys">Question No.${loop.count}</h5>
					</div>
					<div class="form-group">
						<textarea class="form-control text-secondary"
							id="exampleFormControlTextarea1" rows="2" placeholder="Question"
							name="q-${loop.count}" required></textarea>
					</div>
					<br>

					<div class="row">
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(loop.index*4)+1}" placeholder="Option 1"
								autocomplete="off" required />
						</div>
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(loop.index*4)+2}" placeholder="Option 2"
								autocomplete="off" required />
						</div>
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(loop.index*4)+3}" placeholder="Option 3"
								autocomplete="off" required />
						</div>
						<div class="form-group col-lg-3 col-sm-6 mb-3">
							<input type="text" class="form-control text-secondary"
								name="option-${(loop.index*4)+4}" placeholder="Option 4"
								autocomplete="off" required />
						</div>
					</div>

					<div class="row">
						<div class="form-group col-sm-6 col-lg-3 mb-3">
							<input type="text" class="form-control text-secondary"
								name="ans-${loop.count}" placeholder="Answer" autocomplete="off"
								required />
						</div>
						<div class="form-group col-sm-6 col-lg-3">
							<input type="text" class="form-control text-secondary"
								name="mark-${loop.count}" placeholder="Mark" autocomplete="off"
								required />
						</div>
					</div>
				</div>
			</c:forEach>


			<div class="positioncenters">
				<button type="submit" class="btn btn-info text-white mb-3 btns">Save</button>
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

</body>
</html>

