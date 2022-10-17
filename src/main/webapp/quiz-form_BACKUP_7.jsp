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
	<!-- bootstrap css1 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-0evHe/X+R7YkIZDRvuzKMRqM+OrBnVFBL6DOitfPri4tjfHxaWutUpFmBp4vmVor" crossorigin="anonymous">
    <!-- fontawesome css1 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <!-- custom css -->
   	<link href="css/addForm.css" rel="stylesheet" type="text/css">
	<!-- jquery css -->	
    <link rel="stylesheet" href="//code.jquery.com/ui/1.13.2/themes/base/jquery-ui.css">
    <link rel="stylesheet"href="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.css">
  
    <script src="https://code.jquery.com/jquery-3.6.0.js"></script>
    <script src="https://code.jquery.com/ui/1.13.2/jquery-ui.js"></script>
    <!-- datetime picker -->
    <script src="//cdnjs.cloudflare.com/ajax/libs/timepicker/1.3.5/jquery.timepicker.min.js"></script>    	
    
</head>
<body>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
%>
	<header>
        <nav class="navbar navbar-expand-md mb-4">
          <a class="navbar-brand" href="admin-dashboard">
            <img src="http://localhost:8080/online_quiz/img/apple.svg" width="30" height="30" class="d-inline-block align-top" alt="">
            <h5 class="d-inline text-white p-2">Quiz Form</h5>
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
                <li class="nav-item"><a href="courses" class="nav-link mx-3">Courses</a></li>
            </ul>     
            <form action="logout">  
            	<button type="submit" class="btn text-white justify-content-end"><i class="fas fa-sign-out"></i></button>      
            </form>      
          </div>                       
        </nav> 
      </header>		

	<section>
        <div class="bg-white mx-5 text-center center-block col-10 mx-auto card">
          	<form action="question-form" method="post">
          		<h3 class="mb-5  textprimarys"><i class="fas fa-question-circle"></i> Add New Quiz</h3>
				
            	<div class="col-9 mx-auto">
              		<div class="form-group row mb-3">
                		<label class="col-sm-2 col-form-label text-center textprimarys">Name</label>
                		<div class="col-sm-8">
                  			<input type="text" class="form-control text-secondary" id="name" name="name" autocomplete="off" required/>
                  			<small id="name_err" style="color:red;"></small>
                		</div>
              		</div>
              		
              		<div class="form-group row mb-3">
                		<label class="col-sm-2 col-form-label text-center textprimarys">Date</label>
                		<div class="col-sm-8">
                  			<input type="text" class="date form-control text-secondary" id="date" name="date" autocomplete="off" required/>
                  			<small id="date_err" style="color:red;"></small>
                		</div>
              		</div>
              		
              		<div class="form-group row mb-3">
                		<label class="col-sm-2 col-form-label text-center textprimarys">Start Time</label>
                		<div class="col-sm-8">
                  			<input type="text" class="form-control text-secondary" id="datetime" name="stime" autocomplete="off" required/>
                  			<small id="stime_err" style="color:red;"></small>
                		</div>
              		</div>
              		
              		<div class="form-group row mb-3">
                		<label class="col-sm-2 col-form-label text-center textprimarys">Duration</label>
                		<div class="col-sm-8">
                  			<input type="number" class="form-control text-secondary" id="duration" name="duration"  min=1 max = 3 oninput="validity.valid||(value='');" autocomplete="off" required/>
                  			<small id="duration_err" style="color:red;"></small>
                		</div>
              		</div>
              		
              		<div class="form-group row mb-3">
                		<label class="col-sm-2 col-form-label text-center textprimarys">Total Question</label>
                		<div class="col-sm-8">
                  			<input type="number" class="form-control text-secondary" id="qCount" name="questions"  min=1  oninput="validity.valid||(value='');" autocomplete="off" required/>
                  			<small id="qCount_err" style="color:red;"></small>
                		</div>
              		</div>
              		
              		<div class="form-group row mb-3">
                		<label class="col-sm-2 col-form-label text-center textprimarys">Published</label>
                		<div class="col-sm-8">
                			<div class="row">
                				<div class="col">
                  					<input type="radio" class="text-secondary" id="Netflix" name="published"  value="1" checked="checked"/>
                  					<label>Yes</label>
                  				</div>
                  				<div class="col">
                  					<input type="radio" class="text-secondary" id="Netflix" name="published"  value="0" />
                  					<label>No</label>
                  				</div>
                  			</div>
                		</div>
              		</div>
              		
              		<button type="submit" class="btn btn-info text-white m-3 btns" onclick="return quizFormValidate()">Next</button>
              		
            </div>                   
          </form>                    
        </div>    
      </section>
		
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
						      
<<<<<<< HEAD
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
=======
	</script>				   	   
		
	<!-- bootstrap js2 -->
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
    <!-- jquery -->
    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	
>>>>>>> 7bf9c5664541c95cb1b1becc84169aad8489cf90
						
</body>
</html>

