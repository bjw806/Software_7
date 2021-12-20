<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
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
    <form action="act_login.jsp" method="post" class="loginForm" accept-charset="UTF-8">
      <h2>로그인</h2>
      <div class="idForm">
        <input type="text" name="userid" id="userid" class="id" placeholder="ID">
      </div>
      <div class="passForm">
        <input type="password" name="pw" id="pw" class="pw" placeholder="PW">
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