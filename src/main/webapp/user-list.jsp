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
    
</head>
<style>
	.hidetext { -webkit-text-security: disc; /* Default */ }
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
<body>

	<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	%>
	<header>
        <nav class="navbar navbar-expand-md mb-4">
          <a class="navbar-brand" href="admin-dashboard">
            <img src="http://localhost:8080/online_quiz/img/logo.png" width="40" height="30" class="d-inline-block align-top" alt="">
            <h5 class="d-inline text-white p-2"><%= session.getAttribute("currentUserType") %> List</h5>
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
            <form action="logout">  
            	<button type="submit" class="btn text-white justify-content-end"><i class="fas fa-sign-out"></i></button>      
            </form>
          </div>                       
        </nav> 
      </header>
      
      <section>
      		<div class="row justify-content-between align-items-center m-3">
		        <div class="col-xl-3 col-lg-4 col-md-5 col-sm-6 mb-4 d-flex justify-content-sm-start justify-content-between">
		        	<a href="admin-dashboard" type="button" class="btn btns btn-sm margin-right"><i class="fas fa-arrow-alt-circle-left"></i> Back</a>
		            <a href="user-form" type="button" class="btn btn-outline btn-sm btns">+ Add New <%= session.getAttribute("currentUserType") %></a>
		        </div>
		        <div class="col-xl-3 col-lg-4 col-md-5 col-sm-5 mb-4">
		         	<div class="input-group">
		            	 <input type="search" name="search" id="search" onkeyup="tableSearch()" class="form-control form-control-sm rounded-0" placeholder="Search..." />
		            	<button type="button" onclick="tableSearch()" class="btn btn-sm btns"><i class="fas fa-search"></i></button>
		    		</div>          
		       	</div>
			</div>
  		
		<c:if test="${userActionDoneMsg != null}">
			<div class="alert g-alerts">
				<p class="text-secondary"><strong>Success!</strong> Successfully ${userActionDoneMsg} </p>
			</div>
		</c:if>
		
		<c:if test="${userActionFailedMsg != null}">
			<div class="alert alert-danger">
				<p class="text-secondary"><strong>Failed!</strong>  ${userActionFailedMsg}</p>
			</div>
		</c:if>
		
		<%
		// Removing after display
		session.removeAttribute("userActionDoneMsg");
		session.removeAttribute("userActionFailedMsg");
		%>

		<div class="bg-white mx-4 px-3">
			<div class="table-responsive-lg">
	        	<table id="myTable" class="table m-2">
	            	<div class="d-flex justify-content-between align-items-center p-3">
	                	<h5 id="quote"><%= session.getAttribute("currentUserType") %>s</h5>
	                </div>
	                    
	                    <thead>
	                      <tr>
	                        <th scope="col">ID</th>
	                        <th scope="col">USERNAME</th>
	                        <th scope="col">COURSE 1</th>
	                        <th scope="col">COURSE 2</th>
	                        <c:if test="${currentUserType == \"Student\"}">
	                        <th scope="col">COURSE 3</th>
	                        <th scope="col">COURSE 4</th>
	                        <th scope="col">COURSE 5</th>
	                        <th scope="col">COURSE 6</th>
	                        </c:if>
	                        <th scope="col">ACTIONS</th>
	                      </tr>
	                    </thead>
	                    <tbody>
	               			<c:forEach var="u" items="${userList}" varStatus="i">
	
							<tr>
								<td><c:out value="${i.count}" /></td>
								<td><c:out value="${u.email}" /></td>
								<c:forEach var="c" items="${u.courseList}">
									<td><c:out value="${c}" /></td>
								</c:forEach>
								
								<td><a href="user-edit-form?id=<c:out value='${u.id}' />"><i class="fas fa-edit text-info"></i></a>
									&nbsp;&nbsp;&nbsp;&nbsp; 
								<button class="supprimer"  id ="delete-user?id=<c:out value='${u.id}' />&role=<c:out value='${u.role}' />"  onclick="confirmation(this)"> 
									<i class="fas fa-trash-alt text-danger"></i></button></td>
								
							</tr>
						</c:forEach>
	                    </tbody>
	                  </table>
	            </div>
            </div>
      	
      </section>
	
	

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
		<!-- bootstrap js2 -->
	    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
	    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
	    <!-- jquery -->
	    <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
	    <!-- custom js -->
	    <script src="js/user-list.js" type="text/javascript"></script>
</body>
</html>