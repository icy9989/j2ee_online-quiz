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
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <!-- fontawesome css1 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- custom css -->
    <link href="http://localhost:8080/online_quiz/css/dashboard.css" rel="stylesheet" type="text/css">

</head>

<style>
        .card {
            border: none;
            border-radius: 20px;
            box-shadow: 1px 1px 10px #d5e9ee;
            cursor: pointer;
            padding: 0;
            margin: 0;

            overflow: hidden;
        }
        

    </style>
<body>

	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>

	<header>
			<!-- START NAVBAR -->
    		<nav class="navbar navbar-expand-lg">
    
	            <button class="navbar-toggler togglers" data-bs-toggle="collapse" data-bs-target="#mynavbar">
	                <div class="bars barones"></div>
	                <div class="bars bartwos"></div>
	                <div class="bars barthrees"></div>
	            </button>

	            <div id="mynavbar" class="navbar-collapse collapse">
	                <div class="container-fluid">
	                    <div class="row">
	                        <div class="col-xl-2 col-lg-3 col-md-5 fixed-top sidebars">
	                            
	                            <div class="profileboxes">
	                                <div class="mb-3 profileimgs"><h1 class="profiletexts textprimarys">${username}</h1></div>
	                                <p class="fw-bold m-3 beigetexts">${username}</p>
	                            </div>
	                            
	                            <ul class="mt-5 lists">
	                                <li class="listitems disabled"><a href="student-dashboard"><i class="fas fa-home mx-3"></i>Dashboard</a></li>
	                                <li class="listitems courses actives"><a href="#"><i class="fas fa-laptop-code mx-3"></i>Courses</a></li>
	                            </ul>
	
	                            <div class="positioncenters m-5">
	                                <a href="logout" class="btn btn-info text-white btns">Log out</a>
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
                	<a href="http://localhost:8080/online_quiz/student-dashboard" class="text-secondary"><i class="fas fa-arrow-alt-circle-left text-info"></i><span class="fw-bold text-secondary text-uppercase"> Courses</span></a>
                    <div class="row my-3">
                        <div class="col-xl-12">
                            <div class="card">
                                <div class="bg-info p-3">
                                    <h4 class="text-white">${courseName}</h4>
                                </div class="card-body">
                                <div class="p-5 text-center">
                                    <i class="fas fa-book fa-7x"></i>
                                </div>
                                <c:forEach var="q" items="<%=session.getAttribute(\"quiz-list\")%>" varStatus="i">

                                 		<div>
		                                    <ul class="list-group">
		                                        <li class="d-flex align-items-center listitems"><a href="quiz-view?id=${q.id }&std_id=${user_id}" class="textprimarys fw-bold"><div class="list-nos">${i.count}</div>  ${q.name}</a></li>
		                                    </ul>
                                		</div>
                          
								
								</c:forEach>

                            </div>
                        </div>

                    </div>  
                    <!-- End Dashboard --> 
                </div>
                

		 <!-- Start Calendar -->
                <div class="col-xl-3 col-lg-4 col-sm-5 p-5">
                    <div class="calendarcards bg-white">
                        <div class="daycards positioncenters">
                            <p id="day" class="m-0 p-2 text-white"></p>
                        </div>
                        <div class="p-3 text-secondary datecards positioncenters">
                            <p id="month" class="monthfonts"></p>
                            <p class="datefonts"><span id="daydate"></span></p>
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
		
		

	
		<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
        <!-- jquery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js" type="text/javascript"></script>
        <!-- custom js -->
        <script src="http://localhost:8080/online_quiz/js/app.js" type="text/javascript"></script>


</body>
</html>