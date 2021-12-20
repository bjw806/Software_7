<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="assets/css/login-style.css">
    <link rel="apple-touch-icon" href="assets/img/recycling-box-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/box_favicon.ico">
 </head>

  <body width="100%" height="100%">
    <form action="act_login.jsp" method="post" class="loginForm">
      <h2>로그인</h2>
      <div class="idForm">
        <input type="text" id="userid" class="id" placeholder="ID">
      </div>
      <div class="passForm">
        <input type="password" id="PW" class="pw" placeholder="PW">
      </div>
      <button type="submit" class="btn">
        LOG IN
      </button>
      
      <div class="bottomText">
        	아이디가 없으신가요? <a href="signup.jsp">회원가입</a>
      </div>
    </form>
  </body>
		
</body>
</html>