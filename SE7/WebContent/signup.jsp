<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>

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
        <input type="text" name="userID" id="userID" class="id" placeholder="ID">
      </div>
      <div class="passForm">
        <input type="password" name="userPW" id="userPW" class="pw" placeholder="PW">
      </div>
      <div class="nicknameForm">
        <input type="text" name="userNickname" id="userNickname" class="nickname" placeholder="nickname">
      </div>
      <div>
      <button type="submit" class="btn">
		회원가입
      </button>
      <button type="button" OnClick="javascript:history.back(-1)" class="btn">
        	돌아가기
      </button>
      </div>

    </form>
  </body>
</html>
