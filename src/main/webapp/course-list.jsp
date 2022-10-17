<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<title>Online Quiz</title>
	<!-- bootstrap css1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <!-- fontawesome css1 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- custom css -->
    <link href="css/style.css" rel="stylesheet" type="text/css">
	  
	<style type="text/css">
		.supprimer {
		  background-color: transparent;
		  text-decoration: none;
		  border: none;
		  color: red;
		  cursor: pointer;
		}
		
		supprimer:focus {
		  outline: none;
		}
	</style>
</head>
<body>

	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<header>
		<nav class="navbar navbar-expand-md mb-4">
          <a class="navbar-brand" href="admin-dashboard">
            <img src="http://localhost:8080/online_quiz/img/logo.png"
				width="40" height="30" class="d-inline-block align-top" alt="">
				<h5 class="d-inline text-white p-2">Course List</h5>
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
            	<button type="submit" class="btn text-white justify-content-end"><i class="fas fa-sign-out"></i></button>      
            </form>
          </div>                       
        </nav> 
		
	</header>
	
	<div class="row justify-content-between align-items-center m-3">
	 	<div class="col-xl-3 col-lg-4 col-md-5 col-sm-6 mb-4 d-flex justify-content-sm-start justify-content-between">
        	<a href="admin-dashboard" type="button" class="btn btns btn-sm margin-right"><i class="fas fa-arrow-alt-circle-left"></i> Back</a>
            <a href="course-form" type="button" class="btn btn-outline btn-sm btns">+ Add New Course</a>
        </div>
    	<div class="col-xl-3 col-lg-4 col-md-5 col-sm-5 mb-4">
         	<div class="input-group">
            	<input type="search" name="search" id="search" onkeyup="tableSearch()" class="form-control form-control-sm rounded-0" placeholder="Search..." />
            		<button type="button" class="btn btn-sm btns" onclick="tableSearch()"><i class="fas fa-search"></i></button>
    		</div>          
       	</div>
	</div>
  	
  	<c:if test="${courseActionDoneMsg != null}">
  		<div class="alert g-alerts">
			<p class="text-secondary"><strong>Success!</strong> Successfully ${courseActionDoneMsg} </p>
		</div>
	</c:if>
	<c:if test="${courseActionFailedMsg != null}">
		<div class="alert alert-danger">
			<p class="text-secondary"><strong>Failed!</strong>  ${courseActionFailedMsg}</p>
		</div>
	</c:if>		
		
		<%
		// Removing after display
		session.removeAttribute("courseActionDoneMsg");
		session.removeAttribute("courseActionFailedMsg");
		%>
		
		<div class="bg-white mx-4 px-3">
		<div class="table-responsive-lg">
        	<table id="myTable" class="table m-2">
            	<div class="d-flex justify-content-between align-items-center p-3">
                	<h5 id="quote">Courses</h5>
                </div>
                    
                    <thead>
	                    <tr>
							<th>ID</th>
							<th>CODE</th>
							<th>COURSE NAME</th>
							<th>Actions</th>
						</tr>                   
                    </thead>
                    
                    <tbody>
                    	<c:forEach var="course" items="${courseList}" varStatus="i">

						<tr>
							<td><c:out value="${i.count}" /></td>
							<td><c:out value="${course.code}" /></td>
							<td><c:out value="${course.courseName}" /></td>
							<td>
								<a href="course-edit-form?id=<c:out value='${course.id}' />"><i class="fas fa-edit text-info"></i></a>
								&nbsp;&nbsp;&nbsp;&nbsp; 
								<button class="supprimer"   id ="delete-course?id=<c:out value='${course.id}' />"  onclick="confirmation(this)"	> 
								<i class="fas fa-trash-alt text-danger"></i></button>
							
							</td>
						</tr>
						</c:forEach>
                    </tbody>
                  </table>
            </div>
         </div>
	
	
	<script>
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
	
		setTimeout(function () {
			  
	        // Closing the alert
	        $('.alert').alert('close');
	    }, 5000);
	
	</script>
	<!-- jquery -->
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	<!-- bootstrap js2 -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

	<!-- customer js -->
	<script src="js/course-list.js"></script>
 </body>
</html>