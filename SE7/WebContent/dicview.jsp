<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDAO"%>
<%@page import="User.dicboard"%>
<%@page import="User.User"%>
<%@page import="java.io.File" %>
<%@page import= "java.util.ArrayList" %>
<% request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
    <title>재활용앱 </title>
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
	
</head>
<body>
	<%
		String userid = null;
		if(session.getAttribute("userid") != null){
			userid = (String)session.getAttribute("userid");
		}	
	
		int Dnumber = 0;
		if (request.getParameter("Dnumber") != null){
			Dnumber = Integer.parseInt(request.getParameter("Dnumber"));
		}
		if(Dnumber == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 접근입니다.')");
			script.println("location.href='QNAboard.jsp'");
			script.println("</script>");
		}
		UserDAO userdao = new UserDAO();
		
		dicboard dicboard = userdao.getDboard(Dnumber);
		
		String title = dicboard.getTitle();
		String content =dicboard.getContent();
		String nick = userdao.getNick(dicboard.getUserID());
		
	%>
 <!-- Header -->
    <nav class="navbar navbar-expand-lg navbar-light shadow">
        <div class="container d-flex justify-content-between align-items-center">

            <a class="navbar-brand text-success logo h1 align-self-center" href="index.jsp">
               	 재활용앱
            </a>

            <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#templatemo_main_nav" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>

            <div class="align-self-center collapse navbar-collapse flex-fill  d-lg-flex justify-content-lg-between" id="templatemo_main_nav">
                <div class="flex-fill">
                    <ul class="nav navbar-nav d-flex justify-content-between mx-lg-auto">
                        <li class="nav-item">
                            <a class="nav-link" href="dicboard.jsp">백과사전</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="scoreboard.jsp">재활용평가</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" href="QNAboard.jsp">Q&A</a>
                        </li>
                        
                    </ul>
                </div>
                <div class="navbar align-self-center d-flex">
                    <div class="d-lg-none flex-sm-fill mt-3 mb-4 col-7 col-sm-auto pr-3">
                        <div class="input-group">
                            <input type="text" class="form-control" id="inputMobileSearch" placeholder="Search ...">
                            <div class="input-group-text">
                                <i class="fa fa-fw fa-search"></i>
                            </div>
                        </div>
                    </div>
                    <%  
                   	    if (userid != null){
					%>
                    <a class="nav-icon position-relative text-decoration-none" href="option.jsp">
                    	개인정보
                        <i class="fa fa-fw fa-user text-dark mr-3"></i></a>
                    <a class="nav-icon position-relative text-decoration-none" href="act_logout.jsp">
                    	로그아웃
                        <i class="fas fa-sign-out-alt text-dark mr-3"></i></a>
                   <%
                        } else if (userid == null){
					%>
                    <a class="nav-icon position-relative text-decoration-none" href="login.jsp">
                    	로그인
                        <i class="fa fa-fw fa-user text-dark mr-3"></i></a>
                   <%
                        }
                   %>
                </div>
            </div>

        </div>
    </nav>
    <!-- Close Header -->
    <!-- Write -->
    
    
	<div class="container">
		<div class="row">
			
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="5" style="background-color: #eeeeee; text-align: center;">게시글</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2" style="text-align:left">제목</td>
							<td colspan="3"><%=dicboard.getTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:left">작성자</td>
							<td colspan="3"><%=userdao.getNick(dicboard.getUserID())%></td>
						</tr>
						<tr>
							<td colspan="1" style="text-align:left">내용</td>
							<td colspan="3" style="min-height: 200px; text-align:left"><%=dicboard.getContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
							<%
								String directory =application.getRealPath("/upload/");
								String files[] = new File(directory).list();
								String filename=userdao.getFileRealNameD(Dnumber);
								String img_scr ;
								
								
								
								for(int i = 0 ; i < files.length; i++){
									filename=userdao.getFileRealNameD(Dnumber);
									
									if(files[i].equals(userdao.getFileRealNameD(Dnumber))){
										;
										filename=userdao.getFileRealNameD(Dnumber);
							%>
								<td colspan="1" ><img src="<%=request.getContextPath()%>/upload/<%=filename%>" width="400px" height="400px"></td>
							<%
									}
								}
							%>
						</tr>
					</tbody>
				</table>
				<a href="dicboard.jsp" class="btn btn-primary">목록</a>
		</div>
	</div>
	
	<!-- Close Write -->
</html>