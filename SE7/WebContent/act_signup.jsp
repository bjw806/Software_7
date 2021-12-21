<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "beans.user"%>
<%@ page import = "dao.DAO" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="userbean" class="beans.user" scope="page" />
<jsp:setProperty name="userbean" property="userID"/>
<jsp:setProperty name="userbean" property="userPW"/>
<jsp:setProperty name="userbean" property="userNickname"/>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">

<title>Insert title here</title>
</head>
<body>
	<%
		if(userbean.getUserID() == null || userbean.getUserPW() == null || userbean.getUserNickname() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		} 
		else {
			DAO userDAO = new DAO();
			int result = userDAO.join(userbean);
			
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 입력된 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'login.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>