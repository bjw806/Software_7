<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="apple-touch-icon" href="assets/img/recycling-box-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/box_favicon.ico">
    <link rel="stylesheet" type="text/css" href="assets/css/signup-style.css">
 </head>

  <body width="100%" height="100%">
    <form action="act_signup.jsp" method="post" class="singupForm">
      <h2>회원가입</h2>
      <div class="idForm">
        <input type="text" id="userid" class="id" placeholder="ID">
      </div>
      <div class="passForm">
        <input type="password" id="pw" class="pw" placeholder="PW">
      </div>
      <div class="nicknameForm">
        <input type="text" id="nickname" class="nickname" placeholder="nickname">
      </div>
      <button type="submit" class="btn">
        sign up
      </button>
      

    </form>
  </body>
		
</body>
</html>