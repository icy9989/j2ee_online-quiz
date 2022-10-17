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
	<!-- custom css1  -->
	<link rel="stylesheet" href="http://localhost:8080/online_quiz/css/login.css" type="text/css">
</head>
<body>

	<div class="login-cards">
            <div class="row">
                <div class="col-xl-6 col-lg-7 backgrounds">
                    <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp" width="400px"/>
                </div>
                <div class="col-xl-6 col-lg-5 col-md-12 p-5 formbackgrounds">
                    <div class="login-forms">
                        <img src="http://localhost:8080/online_quiz/img/logo.png" class="my-4 logos" />
                        <h2 class="fw-bold">WELCOME</h2>
                        <p style="color: red;">${errorMessage}</p>
                       
                        <form action="login" method="post">
                        

                            <div class="form-group my-4">       
                                <input type="email" name="email" id="username" class="form-control text-secondary inputs" placeholder="Username" autocomplete="off" required />
                                <i class="fas fa-user icons"></i>
                            </div>
                    
                            <div class="form-group eyeboxes my-4">    
                                <input type="password" name="password" id="password" class="form-control text-secondary inputs" placeholder="Password" autocomplete="off" required />
                                <i class="fas fa-key icons"></i> <i class="fas fa-eye eyeicons text-secondary"></i>
                            </div>

                            <div class="d-grid mb-4 py-4">
                                <button type="submit" class="btn btn-info fw-bold text-white text-uppercase login-btns" value="login">Log In</button>
                            </div>
                            
                        </form>
                    </div>
                </div>
            </div>    
            
        </div>
        
        <!-- bootstrap js2 -->
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.5/dist/umd/popper.min.js" integrity="sha384-Xe+8cL9oJa6tN/veChSP7q+mnSPaj5Bcu9mPX5F5xIGE0DVittaqT5lorf0EI7Vk" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/js/bootstrap.min.js" integrity="sha384-kjU+l4N0Yf4ZOJErLsIcvOU2qSb74wXpOhqTvwVx3OElZRweTnQ6d31fXEoRD1Jy" crossorigin="anonymous"></script>
        <!-- custom js -->
        <script src="http://localhost:8080/online_quiz/js/login.js" type="text/javascript"></script>

</body>
</html>