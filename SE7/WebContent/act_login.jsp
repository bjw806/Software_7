<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="dao.DAO"%>
<%@page import="dao.DB"%>
<%@page import="beans.*"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인중</title>
</head>
<body>
<%
	DB db = new DB();
	db.connect();
	
	DAO dao = new DAO();
	
	String userID= request.getParameter("userid");
	String userPW= request.getParameter("pw");
	
	int result = dao.login(userID, userPW);
	if(result == 1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인 성공')");
		script.println("location.href='main.jsp'");
		script.println("</script>");
	}else if(result == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('비밀번호가 틀립니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('존재하지 않는 아이디입니다')");
		script.println("history.back()");
		script.println("</script>");
	}else if(result == -2){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('데이터베이스 오류입니다')");
		script.println("history.back()");
		script.println("</script>");
	}
%>
	
</body>
</html>