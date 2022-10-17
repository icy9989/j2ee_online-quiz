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
    <link href="http://localhost:8080/online_quiz/css/style.css" rel="stylesheet" type="text/css">
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
	<header>
        <nav class="navbar navbar-expand-md mb-4">
	    	<a class="navbar-brand" href="instructor-dashboard">
	            <img src="http://localhost:8080/online_quiz/img/logo.png" width="40" height="30" class="d-inline-block align-top" alt="">
	            <h5 class="d-inline text-white p-2">Quiz List</h5>
	          </a>       

	          <button class="navbar-toggler text-white togglers" data-bs-toggle="collapse" data-bs-target="#navbarcollapse">
	            <div class="bars barones"></div>
	            <div class="bars bartwos"></div>
	            <div class="bars barthrees"></div>
	          </button>
          
          <div id="navbarcollapse" class="navbar-collapse collapse justify-content-end">
          		<ul class="navbar-nav">
	                <li class="nav-item"><a href="instructor-dashboard" class="nav-link mx-3">Dashboard</a></li>
	                <li class="nav-item"><a href="instructor-dashboard" class="nav-link mx-3">Students</a></li>
	                <li class="nav-item"><a href="instructor-dashboard" class="nav-link mx-3">Courses</a></li>
	            </ul>        
	            <form action="logout">  
	            	<button type="submit" class="btn text-white justify-content-end"><i class="fas fa-sign-out"></i></button>      
	            </form>
         </div>                       
      </nav> 
    </header>
	
	<section>
    	<div class="row justify-content-between align-items-center m-3">
    		<div class="col-xl-3 col-lg-4 col-md-5 col-sm-6 mb-4 d-flex justify-content-sm-start justify-content-between">
    	        <button class="btn btns btn-sm margin-right" type="button" name="back" onclick="history.back()"><i class="fas fa-arrow-alt-circle-left"></i> Back</button>
        	</div>
	    	<div class="col-xl-3 col-lg-4 col-md-5 col-sm-5 mb-4">
	         	<div class="input-group">
	            	<input type="search" name="search" id="search" class="form-control form-control-sm rounded-0" onkeyup="tableSearch()" placeholder="Search..." />
	            	<button type="button" class="btn btn-sm btns" onclick="tableSearch()"><i class="fas fa-search"></i></button>
	    		</div>          
	       	</div>
		</div>
		
		<div class="bg-white mx-4 px-3">
			<div class="table-responsive-lg">
	        	<table id="myTable" class="table m-2">
	            	<div class="d-flex justify-content-between align-items-center p-3">
	                	<h5 id="quote">${course_code} - All Quizzes</h5>  
	                </div>
	                    
	                    <thead>
	                      <tr>
	                        <th rowspan="1">NO</th>
							<th rowspan="2">NAME</th>
							<th rowspan="2">DATE</th>
							<th rowspan="1">MARK</th>
							<th rowspan="2">Details</th>
	                      </tr>
	                    </thead>
	                    <tbody>
	               			<c:forEach var="sq" items="${sqlist}" varStatus="i">
								<tr>
									<td><c:out value="${i.count}" /></td>
									<td><c:out value="${sq.name}" /></td>
									<td><c:out value="${sq.date}" /></td>
									<td><c:out value="${sq.studentMark.mark}/${sq.total_mark}" /></td>
									<td><a href="quiz-view?id=${sq.id}&std_id=${sq.studentMark.id}"><span class="badge bg-warning">view</span></a></td>
								</tr>						
							</c:forEach>					
	
	                    </tbody>
	                  </table>
	            </div>
            </div>
		
    </section>

		<!-- bootstrap js2 -->
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
	    <!-- jquery -->
	    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
		<script src="js/quiz-list.js" type="text/javascript"></script>
</body>
</html>

