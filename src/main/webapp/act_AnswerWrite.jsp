<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDAO"%>
<%@page import="User.qboard"%>
<%@page import="User.User"%>
<%@page import="java.util.ArrayList" %>
<%@page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 중</title>
</head>
<body>
<%	
	String Title = request.getParameter("Title");
	String Content = request.getParameter("Content");
	//세션이 만료되거나 로그인이 안되어 있다면 해당 페이지에서 내보낸다.
	String userid = null;
	if(session.getAttribute("userid") != null){
		userid = (String)session.getAttribute("userid");
	}
	// 로그인을 한 사람만 글을 쓸 수 있도록 코드를 수정한다
	if(userid == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요')");
		script.println("location.href='login.jsp'");
		script.println("</script>");
	}else if(Title == null || Title.isEmpty() || Content.isEmpty() || Content == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('제목과 내용은 공백일 수 없습니다.')");
		script.println("history.back()");
		script.println("</script>");
	}else{
	// 정상적으로 입력이 되었다면 글쓰기 로직을 수행한다
	UserDAO userdao = new UserDAO();
	
	int Qnumber = Integer.parseInt(request.getParameter("Qnumber"));
	int result = userdao.AsnwerWrite(Title, Content, userid, Qnumber);
	// 데이터베이스 오류인 경우
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글쓰기에 실패했습니다')");
		script.println("history.back()");
		script.println("</script>");
	// 글쓰기가 정상적으로 실행되면 알림창을 띄우고 게시판 메인으로 이동한다
	}else {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('글쓰기 성공')");
		script.println("history.back()");
		script.println("</script>");
	}
	}
%>	
</body>
</html>