<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
    <title>테스트용 </title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <link rel="apple-touch-icon" href="assets/img/recycling-box-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/box_favicon.ico">

    <link rel="stylesheet" href="assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="assets/css/templatemo.css">
    <link rel="stylesheet" href="assets/css/custom.css">

    <!-- Load fonts style after rendering the layout styles -->
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@100;200;300;400;500;700;900&display=swap">
    <link rel="stylesheet" href="assets/css/fontawesome.min.css">

	<meta charset="UTF-8">
    <link rel="stylesheet" type="text/css" href="assets/css/login-style.css">
    <link rel="apple-touch-icon" href="assets/img/recycling-box-icon.png">
    <link rel="shortcut icon" type="image/x-icon" href="assets/img/box_favicon.ico">
 </head>

  <body width="100%" height="100%">
  <%
	//로그인이 되어있는 상태로 로그인 login 에 접근한 경우
	String userid = null;
	if (session.getAttribute("userid") != null){
		userid = (String) session.getAttribute("userid");
	}
	if (userid != null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 로그인 되어있습니다.')");
		script.println("location.href='index.jsp'");
		script.println("</script>");
	}
  %>
   
    <!-- Write -->
	<form action="act_login.jsp" method="post" class="loginForm" accept-charset="UTF-8">
      <h2>로그인</h2>
      <div class="idForm">
        <input type="text" name="userid" id="userid" class="id" placeholder="ID">
      </div>
      <div class="passForm">
        <input type="password" name="pw" id="pw" class="pw" placeholder="PW">
      </div>
     
      <div>
      <button type="submit" class="btn">
		LOG IN
      </button>
      <button type="button" OnClick="javascript:history.back(-1)" class="btn">
        	돌아가기
      </button>
      </div>
      <div class="bottomText">
        	아이디가 없으신가요? <a href="signup.jsp">회원가입</a>
      </div>
		
			
	</form>
  </body>
</html>