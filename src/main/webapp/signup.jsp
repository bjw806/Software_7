<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="assets/css/signup-style.css">
 </head>
  <body width="100%" height="100%">
    <form action="act_signup.jsp" method="post" id="signup" name="signup" class="signupForm">
      <h2>회원가입</h2>
      <div class="idForm">
        <p></p><label>ID : </label><input type="text" id="userID" name="userID" class="userID" placeholder="ID" maxlength="20">
      </div>
      <div class="passForm">
        <p></p><label>비밀번호 : </label><input type="password" id="userPW" name="userPW" class="userPW" placeholder="PW" maxlength="20">
      </div>
      <div class="nicknameForm">
        <p></p><label>닉네임 : </label><input type="text" id="userNickname" name="userNickname" class="userNickname" placeholder="nickname" maxlength="10">
        <br><br>
      </div>
      <button type="submit" class="btn">
        sign up
      </button>
    </form>
  </body>
</body>
</html>