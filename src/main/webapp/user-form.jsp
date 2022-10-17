<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.List"%>
<%@ page import="model.Course"%>
<html>
<head>
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
<link href="css/form.css" rel="stylesheet" type="text/css">
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
				<h5 class="d-inline text-white p-2"><%=session.getAttribute("currentUserType")%>
					Form
				</h5>
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
					<li class="nav-item"><a href="instructor"
						class="nav-link mx-3">Instructors</a></li>
					<li class="nav-item"><a href="courses" class="nav-link mx-3">Courses</a></li>
				</ul>
				<form action="logout" class="p-0 m-0">
					<button type="submit" class="btn text-white justify-content-end">
						<i class="fas fa-sign-out"></i>
					</button>
				</form>
			</div>
		</nav>
	</header>

	<section>

		<button class="btn btns btn-sm margin-right mb-3 mx-4" type="button"
			name="back" onclick="history.back()">
			<i class="fas fa-arrow-alt-circle-left"></i> Back
		</button>

		<div
			class="bg-white mx-5 text-center center-block col-10 mx-auto card">
			<div>
				<c:if test="${currentuser != null}">
					<form action="update-user" method="post">
				</c:if>
				<c:if test="${currentuser == null}">
					<form action="insert-user" method="post">
				</c:if>

				<c:if test="${currentuser != null}">
					<c:if test="${currentUserType == \"Student\"}">
						<h3 class="mb-5 textprimarys">
							<i class="fas fa-edit"></i> Edit ${currentUserType}
						</h3>
					</c:if>
					<c:if test="${currentUserType == \"Instructor\"}">
						<h3 class="mb-5 pt-5 textprimarys">
							<i class="fas fa-edit"></i> Edit ${currentUserType}
						</h3>
					</c:if>
				</c:if>
				<c:if test="${currentuser == null}">
					<c:if test="${currentUserType == \"Student\"}">
						<h3 class="mb-5 textprimarys">
							<i class="fas fa-user-plus"></i> Add New ${currentUserType}
						</h3>
					</c:if>
					<c:if test="${currentUserType == \"Instructor\"}">
						<h3 class="mb-5 pt-5 textprimarys">
							<i class="fas fa-user-plus"></i> Add New ${currentUserType}
						</h3>
					</c:if>

				</c:if>

			</div>

			<div id="r1"></div>
			<c:if test="${currentuser != null}">
				<input type="hidden" name="id"
					value="<c:out value='${currentuser.id}' />" />
			</c:if>


			<div class="col-9 mx-auto">
				<div class="form-group row mb-3">
					<label for="username"
						class="col-sm-2 col-form-label text-center textprimarys">Username</label>
					<div class="col-sm-8">
						<input type="text"
							value="<c:out value='${currentuser.username}'/>"
							class="form-control text-secondary" id="uname" name="username"
							autocomplete="off" required /> <small id="name_err"
							style="color: red;"></small>
					</div>
				</div>
				<div class="form-group row mb-3">
					<label for="email"
						class="col-sm-2 col-form-label text-center textprimarys">Email</label>
					<div class="col-sm-8">
						<input type="email" value="<c:out value='${currentuser.email}'/>"
							class="form-control text-secondary" id="email" name="email"
							autocomplete="off" required /> <small id="email_err"
							style="color: red;"></small>
					</div>
				</div>
				<input type="hidden" name="role"
					value="<%=session.getAttribute("currentUserType")%>" />
				<c:choose>
					<c:when test="${currentuser != null}">
						<input type="hidden" name="password"
							value="${currentuser.password }" />
					</c:when>
					<c:otherwise>
						<input type="hidden" name="password" value="123" />
					</c:otherwise>
				</c:choose>

				<div class="form-group row mb-3">
					<label class="col-sm-2 col-form-label text-center textprimarys">Course
						1</label>
					<div class="col-sm-8">
						<select id="c1" name="course1" class="form-select text-secondary"
							aria-label="Default select example" required>
							<c:if test="${currentuser == null}">
								<option selected disabled value="">Choose...</option>
								<c:forEach var="c" items="${courses }">
									<option value="${c.code}">${c.courseName}</option>
								</c:forEach>
							</c:if>
							<c:if test="${currentuser != null}">
								<option selected
									value="${ courses.stream().filter(e -> e.getCourseName()==currentuser.getCourseList().get(0)).map(e->e.getCode()).toList().get(0)}">${currentuser.getCourseList().get(0) }</option>
								<c:forEach var="c" items="${courses }">
									<c:if
										test="${currentuser.getCourseList().get(0) != c.courseName}">
										<option value="${c.code}">${c.courseName}</option>
									</c:if>
								</c:forEach>
							</c:if>
						</select> <small id="c1_err" style="color: red;"></small>
					</div>
				</div>

				<div class="form-group row mb-3">
					<label class="col-sm-2 col-form-label text-center textprimarys">Course
						2</label>
					<div class="col-sm-8">
						<select id="c2" name="course2" class="form-select text-secondary"
							aria-label="Default select example" required>
							<c:if test="${currentuser == null}">
								<option selected disabled value="">Choose...</option>
								<c:forEach var="c" items="${courses }">
									<option value="${c.code}">${c.courseName}</option>
								</c:forEach>
							</c:if>
							<c:if test="${currentuser != null}">
								<option selected
									value="${ courses.stream().filter(e -> e.getCourseName()==currentuser.getCourseList().get(1)).map(e->e.getCode()).toList().get(0)}">${currentuser.getCourseList().get(1) }</option>
								<c:forEach var="c" items="${courses }">
									<c:if
										test="${currentuser.getCourseList().get(0) != c.courseName}">
										<option value="${c.code}">${c.courseName}</option>
									</c:if>
								</c:forEach>
							</c:if>
						</select> <small id="c2_err" style="color: red;"></small>
					</div>
				</div>

				<c:if test="${currentUserType == \"Student\"}">
					<div class="form-group row mb-3">
						<label class="col-sm-2 col-form-label text-center textprimarys">Course
							3</label>
						<div class="col-sm-8">
							<select id="c3" name="course3" class="form-select text-secondary"
								aria-label="Default select example" required>
								<c:if test="${currentuser == null}">
									<option selected disabled value="">Choose...</option>
									<c:forEach var="c" items="${courses }">
										<option value="${c.code}">${c.courseName}</option>
									</c:forEach>
								</c:if>
								<c:if test="${currentuser != null}">
									<option selected
										value="${ courses.stream().filter(e -> e.getCourseName()==currentuser.getCourseList().get(2)).map(e->e.getCode()).toList().get(0)}">${currentuser.getCourseList().get(2) }</option>
									<c:forEach var="c" items="${courses }">
										<c:if
											test="${currentuser.getCourseList().get(0) != c.courseName}">
											<option value="${c.code}">${c.courseName}</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select> <small id="c3_err" style="color: red;"></small>
						</div>
					</div>

					<div class="form-group row mb-3">
						<label class="col-sm-2 col-form-label text-center textprimarys">Course
							4</label>
						<div class="col-sm-8">
							<select id="c4" name="course4" class="form-select text-secondary"
								aria-label="Default select example" required>
								<c:if test="${currentuser == null}">
									<option selected disabled value="">Choose...</option>
									<c:forEach var="c" items="${courses }">
										<option value="${c.code}">${c.courseName}</option>
									</c:forEach>
								</c:if>
								<c:if test="${currentuser != null}">
									<option selected
										value="${ courses.stream().filter(e -> e.getCourseName()==currentuser.getCourseList().get(3)).map(e->e.getCode()).toList().get(0)}">${currentuser.getCourseList().get(3) }</option>
									<c:forEach var="c" items="${courses }">
										<c:if
											test="${currentuser.getCourseList().get(0) != c.courseName}">
											<option value="${c.code}">${c.courseName}</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select> <small id="c4_err" style="color: red;"></small>
						</div>
					</div>

					<div class="form-group row mb-3">
						<label class="col-sm-2 col-form-label text-center textprimarys">Course
							5</label>
						<div class="col-sm-8">
							<select id="c5" name="course5" class="form-select text-secondary"
								aria-label="Default select example" required>
								<c:if test="${currentuser == null}">
									<option selected disabled value="">Choose...</option>
									<c:forEach var="c" items="${courses }">
										<option value="${c.code}">${c.courseName}</option>
									</c:forEach>
								</c:if>
								<c:if test="${currentuser != null}">
									<option selected
										value="${ courses.stream().filter(e -> e.getCourseName()==currentuser.getCourseList().get(4)).map(e->e.getCode()).toList().get(0)}">${currentuser.getCourseList().get(4) }</option>
									<c:forEach var="c" items="${courses }">
										<c:if
											test="${currentuser.getCourseList().get(0) != c.courseName}">
											<option value="${c.code}">${c.courseName}</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select> <small id="c5_err" style="color: red;"></small>
						</div>
					</div>

					<div class="form-group row mb-3">
						<label class="col-sm-2 col-form-label text-center textprimarys">Course
							6</label>
						<div class="col-sm-8">
							<select id="c6" name="course6" class="form-select text-secondary"
								aria-label="Default select example" required>
								<c:if test="${currentuser == null}">
									<option selected disabled value="">Choose...</option>
									<c:forEach var="c" items="${courses }">
										<option value="${c.code}">${c.courseName}</option>
									</c:forEach>
								</c:if>
								<c:if test="${currentuser != null}">
									<option selected
										value="${ courses.stream().filter(e -> e.getCourseName()==currentuser.getCourseList().get(5)).map(e->e.getCode()).toList().get(0)}">${currentuser.getCourseList().get(5) }</option>
									<c:forEach var="c" items="${courses }">
										<c:if
											test="${currentuser.getCourseList().get(0) != c.courseName}">
											<option value="${c.code}">${c.courseName}</option>
										</c:if>
									</c:forEach>
								</c:if>
							</select> <small id="c6_err" style="color: red;"></small>
						</div>
					</div>
				</c:if>

				<button id="${currentUserType}" type="submit"
					class="btn btn-info text-white mt-3 btns"
					onclick="return courseValidation(this)">Save</button>
			</div>
			</form>
		</div>
	</section>

	<script>
		function courseValidation(b) {
			var valid = true;
			var currentUserType = b.getAttribute("id");

			const emptyField = "field is empty";

			if (document.getElementById("uname").value == "") {
				document.getElementById("name_err").innerHTML = emptyField;
				valid = false;
			} else {
				document.getElementById("name_err").innerHTML = "";
			}
			if (document.getElementById("email").value == "") {
				document.getElementById("email_err").innerHTML = emptyField;
				valid = false;
			} else {
				document.getElementById("email_err").innerHTML = "";
			}
			if (document.getElementById("c1").value == "") {
				document.getElementById("c1_err").innerHTML = emptyField;
				valid = false;
			} else {
				document.getElementById("c1_err").innerHTML = "";
			}
			if (document.getElementById("c2").value == "") {
				document.getElementById("c2_err").innerHTML = emptyField;
				valid = false;
			} else {
				document.getElementById("c2_err").innerHTML = "";
			}
			if (currentUserType === "Student") {
				if (document.getElementById("c3").value == "") {
					document.getElementById("c3_err").innerHTML = emptyField;
					valid = false;
				} else {
					document.getElementById("c3_err").innerHTML = "";
				}
				if (document.getElementById("c4").value == "") {
					document.getElementById("c4_err").innerHTML = emptyField;
					valid = false;
				} else {
					document.getElementById("c4_err").innerHTML = "";
				}
				if (document.getElementById("c5").value == "") {
					document.getElementById("c5_err").innerHTML = emptyField;
					valid = false;
				} else {
					document.getElementById("c5_err").innerHTML = "";
				}
				if (document.getElementById("c6").value == "") {
					document.getElementById("c6_err").innerHTML = emptyField;
					valid = false;
				} else {
					document.getElementById("c6_err").innerHTML = "";
				}
			}
			if (currentUserType === "Student") {
				var c1 = document.getElementById("c1").value;
				var c2 = document.getElementById("c2").value;
				var c3 = document.getElementById("c3").value;
				var c4 = document.getElementById("c4").value;
				var c5 = document.getElementById("c5").value;
				var c6 = document.getElementById("c6").value;

				if ((c1 != "" && c2 != "") && c1 == c2
						|| (c1 != "" && c3 != "") && c1 == c3
						|| (c1 != "" && c4 != "") && c1 == c4
						|| (c1 != "" && c5 != "") && c1 == c5
						|| (c1 != "" && c6 != "") && c1 == c6
						|| (c2 != "" && c3 != "") && c2 == c3
						|| (c2 != "" && c4 != "") && c2 == c4
						|| (c2 != "" && c5 != "") && c2 == c5
						|| (c2 != "" && c6 != "") && c2 == c6
						|| (c3 != "" && c4 != "") && c3 == c4
						|| (c3 != "" && c5 != "") && c3 == c5
						|| (c3 != "" && c6 != "") && c3 == c6
						|| (c4 != "" && c5 != "") && c4 == c5
						|| (c4 != "" && c6 != "") && c4 == c6
						|| (c5 != "" && c6 != "") && c5 == c6) {
					var wrapper = document.createElement("div");
					wrapper.innerHTML = '<div class="alert alert-danger text-secondary" role="alert" id="course_error">'
							+ "Duplicate Course" + '</div>'
					if (!document.body.contains(document
							.getElementById("course_error"))) {
						document.getElementById("r1").insertBefore(wrapper,
								null);
					}
					valid = false;
				} else {
					document.getElementById("course_error").remove();
				}
			}
			if (currentUserType === "Instructor") {
				var c1 = document.getElementById("c1").value;
				var c2 = document.getElementById("c2").value;
				if ((c1 != "" && c2 != "") && c1 == c2) {
					var wrapper = document.createElement("div");
					wrapper.innerHTML = '<div class="alert alert-danger" role="alert" id="course_error">'
							+ "Duplicate Course" + '</div>'
					if (!document.body.contains(document
							.getElementById("course_error"))) {
						document.getElementById("r1").insertBefore(wrapper,
								null);
					}
					valid = false;
				} else {
					document.getElementById("course_error").remove();
				}
			}
			return valid;
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