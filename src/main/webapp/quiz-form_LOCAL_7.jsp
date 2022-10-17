<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="java.util.UUID" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="java.time.LocalDateTime" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Online Quiz</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  	<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>
	<script type ="text/javascript" src="http://localhost:8080/online_quiz/js/form_validation.js"></script>
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet" href="/resources/demos/style.css">
    <link rel="stylesheet"href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>    
</head>
<body>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
			<header>
					<nav class="navbar navbar-expand-md navbar-dark"
						style="background-color: #ab62e3">
						<div class="container-fluid">
			    			<a href="#" class="navbar-brand">Online Quiz</a>
			   			</div>
			   			
			   			<div>
						   		 <ul class="navbar-nav mr-auto mt-2 mt-lg-0">
						      <li class="nav-item active">
						        <form action="logout">
						        	<input type="submit" value="Logout" class="btn btn-success">
						        </form>
						      </li>
						      
						    </ul>
						   </div>
					</nav>
					
				</header>

			<div class="col">
					<div class="col-12 col-md-12">
						<h2 class="card-title text-left">New Quiz</h2>
						<hr>
					</div>			
						<form action="question-form" method="post">
						

						  <div class="form-group col-12 col-md-6">
						    <label>Name</label>
						    <input type="text" class="form-control" name="name" id = "name" required>
						    <small id="name_err" style="color:red;"></small>
						  </div>				
						
						  <div class="form-group col-12 col-md-6">
						        <div style="position: relative">
						        	<label>Date</label>
						        	<input type="text" class="date form-control" name = "date" id = "date" />
						        	<small id="date_err" style="color:red;"></small>
						   		 </div>
						    </div>
						    
						  <div class="form-group col-12 col-md-6">
						        <div style="position: relative">
									<label>Start Time</label>
						            <input class="form-control" name = "stime"
						                type="text" id="datetime" />
						            <small id="stime_err" style="color:red;"></small>
						        </div>
						    </div>

						    
						   <div class="form-group col-12 col-md-6">
						    <label>Duration (Minute)</label>
						    <input type="number" class="form-control" oninput="validity.valid||(value='');" min=0 name="duration" id = "duration"  required>
						    <small id="duration_err" style="color:red;"></small>
						  </div>
						  
						  <div class="form-group col-12 col-md-6">
						    <label>Total Question</label>
						    <input type="number" class="form-control" oninput="validity.valid||(value='');" min=1 name="questions" id = "qCount"  required>
						    <small id="qCount_err" style="color:red;"></small>
						  </div>
						  
						  
						  <div class="form-group col-12 col-lg-4 col-md-4">
						  	<label>Published</label>
						   <div class="row">
						   		<div class="col">
						   			<input type="radio"  id="Netflix" name="published" value="1" checked="checked" >
							    	<label>Yes</label>
						   		</div>
						   		<div class="col">
						   			<input type="radio" id="Netflix" name="published" value="0">
							    	<label>No</label>
						   		</div>
							    
							  </div>
							 
						  	</div>
						  	
						  <div class="form-group col-lg-12 col-sm-12">
								<button type="submit" onclick="return quizFormValidate()" class="btn btn-success">Next</button>
						  </div>
						</form>
					      
					   </div> 
					   	   <script>
					   	   		function quizFormValidate(){
					   	   		var valid = true;
					   			
					   			const emptyField = "*field is empty*";
					   			
					   		    if(document.getElementById("name").value == ""){
					   		    	document.getElementById("name_err").innerHTML = emptyField;
					   		    	valid = false;
					   		    }
					   		    
					   		    else{
					   		    	document.getElementById("name_err").innerHTML = "";
					   		    }
					   		 	
					   		    if(document.getElementById("datetime").value == ""){
					   		    	document.getElementById("stime_err").innerHTML = emptyField;
					   		    	valid = false;
					   		    }
					   		    
					   		    else{
					   		    	document.getElementById("stime_err").innerHTML = "";
					   		    }
					   		    
					   		 	if(document.getElementById("date").value == ""){
					   		    	document.getElementById("date_err").innerHTML = emptyField;
					   		    	valid = false;
					   		    }
					   		 	
					   		    else{
					   		    	document.getElementById("date_err").innerHTML = "";
					   		    }
					   		 	
						   	 	if(document.getElementById("duration").value == ""){
						   		    	document.getElementById("duration_err").innerHTML = emptyField;
						   		    	valid = false;
						   		}
						   	 	
						   	    else{
						   		    	document.getElementById("duration_err").innerHTML = "";
						   		}
						   	 	
						   		if(document.getElementById("qCount").value == ""){
					   		    	document.getElementById("qCount_err").innerHTML = emptyField;
					   		    	valid = false;
					   		    }
						   		
					   		    else{
					   		    	document.getElementById("qCount_err").innerHTML = "";
					   		    }
					   		    return valid;
					   	   		}
					   	   </script>
					       <script>
					        $('#datetime').timepicker({
					           timeFormat: 'h:mm p',  
					           minTime: '9',  
					           interval: '60',
					           maxTime: '5:00pm',  
					           startTime: '9:00',  
					           defaultTime: '0'
					        });
					    </script>
					        <script type="text/javascript">
					        var dateToday = new Date();

						      $('#date').datepicker({
						    	  numberOfMonths: 1,
						    	  dateFormat: "dd/mm/yy",
						    	  minDate: 0,
						    	  maxDate: '10D'
						      });
						      
						    </script>
						
</body>
</html>

