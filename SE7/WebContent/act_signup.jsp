<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "User.UserDAO"%>
<%@ page import = "User.User" %>
<%@ page import = "java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset-UTF-8">
<title>sign up</title>
</head>
<body>
	<%
		String userID = null;
		String userPW = null;
		String userNickname = null;
		
		userID= request.getParameter("userID");
		userPW= request.getParameter("userPW");
		userNickname= request.getParameter("userNickname");
		
		
		UserDAO dao = new UserDAO();
		
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
		if (userID == null || userPW == null || userNickname == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(userID, userPW, userNickname);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('이미 입력된 아이디입니다.')");
				script.println("history.back()");
				script.println("</script>");
			} else {
				session.setAttribute("userid",userID);
				
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('로그인 성공')");
				script.println("location.href='index.jsp'");
				script.println("</script>");
				//PrintWriter script = response.getWriter();
				//script.println("<script>");
				//script.println("alert('회원가입이 완료됐습니다. 다시 로그인해주십시오.')");
				//script.println("location.href = 'login.jsp'");
				//script.println("</script>");
			}
		}
	%>
</body>
</html>