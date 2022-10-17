

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
	<title>Online Quiz</title>
	<!-- bootstrap css1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
   	<!-- fontawesome css1 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- custom css -->
    <link href="http://localhost:8080/online_quiz/css/style.css" rel="stylesheet" type="text/css">  
    <link href="http://localhost:8080/online_quiz/css/form.css" rel="stylesheet" type="text/css">    
</head>
<body>
	<%
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	
	%>
	
	<header>
		<nav class="navbar navbar-expand-md mb-4">
          <a class="navbar-brand" href="admin-dashboard">
            <img src="http://localhost:8080/online_quiz/img/logo.png" width="40" height="30" class="d-inline-block align-top" alt="">
            <h5 class="d-inline text-white p-2">Course Form</h5>
          </a> 

          <button class="navbar-toggler text-white togglers" data-bs-toggle="collapse" data-bs-target="#navbarcollapse">
            <div class="bars barones"></div>
            <div class="bars bartwos"></div>
            <div class="bars barthrees"></div>
          </button>
          
          <div id="navbarcollapse" class="navbar-collapse collapse justify-content-end">
            <ul class="navbar-nav">
                <li class="nav-item"><a href="admin-dashboard" class="nav-link mx-3">Dashboard</a></li>
                <li class="nav-item"><a href="student" class="nav-link mx-3">Students</a></li>
                <li class="nav-item"><a href="instructor" class="nav-link mx-3">Instructors</a></li>
                <li class="nav-item"><a href="courses" class="nav-link mx-3">Courses</a></li>
            </ul>
				<form action="logout" class="m-0 p-0">
					<button type="submit" class="btn text-white justify-content-end">
						<i class="fas fa-sign-out"></i>
					</button>
				</form>
			</div>                       
        </nav> 		
	</header>
	
	<section>
	
		<button class="btn btns btn-sm margin-right mb-3 mx-4" type="button" name="back" onclick="history.back()"><i class="fas fa-arrow-alt-circle-left"></i> Back</button>
		
        <div class="bg-white mx-5 text-center center-block col-8 mx-auto card">
        <div>         
          	<c:if test="${course != null}">
					<form action="update-course" method="post">
				</c:if>
				<c:if test="${course == null}">
					<form action="insert-course" method="post">
			</c:if>
			
			<c:if test="${course != null}">
            	<h3 class="mb-5 pt-5 textprimarys"><i class="fas fa-edit"></i> Edit Course</h3>
            </c:if>
			<c:if test="${course == null}">
            	<h3 class="mb-5 pt-5 textprimarys"><i class="fas fa-book"></i> Add New Course</h3>
            </c:if>   
         
          </div>
          
			<c:if test="${course != null}">
				<input type="hidden" name="id" value="<c:out value='${course.id}' />" />
			</c:if>        
			
			<div class="col-9 mx-auto">
              <div class="form-group row mb-3">
                <label class="col-sm-3 col-form-label text-center textprimarys">Code</label>
                <div class="col-sm-9">
                  <input type="text" value="<c:out value='${course.code}' />" class="form-control text-secondary" id="code" name="code" autocomplete="off" required/>
                  <small id="code_err" style="color:red;"></small>
                </div>
              </div>
              
              <div class="form-group row mb-3">
                <label class="col-sm-3 col-form-label text-center textprimarys">Course Name</label>
                <div class="col-sm-9">
                  <input type="text" value="<c:out value='${course.courseName}' />" class="form-control text-secondary" id = "course"
						name="courseName" autocomplete="off" required/>
                  <small id="course_err" style="color:red;"></small>
                </div>
              </div>
             	
               
              <button type="submit" class="btn btn-info text-white m-3 btns" onclick="return validateForm()">Save</button>
            </div>                   
          </form>                    
        </div>    
      </section>

	
	<script>
	function validateForm() {
		var valid = true;		
		const emptyField = "field is empty";
		
	    if(document.getElementById("code").value == ""){
	    	document.getElementById("code_err").innerHTML = emptyField;
	    	valid = false;
	    }
	    else{
	    	document.getElementById("code_err").innerHTML = "";
	    }
	    if(document.getElementById("course").value == ""){
	    	document.getElementById("course_err").innerHTML = emptyField;
	    	valid = false;
	    }
	    else{
	    	document.getElementById("course_err").innerHTML = "";
	    }
	   
		  return valid;
		}
	</script>
</body>
</html>