<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDAO"%>
<%@page import="User.scoreboard"%>
<%@page import="User.User"%>
<%@page import="User.scoreboard"%>
<%@page import="java.io.File" %>
<%@page import= "java.util.ArrayList" %>

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
	
		int Enumber = 0;
		if (request.getParameter("Enumber") != null){
			Enumber = Integer.parseInt(request.getParameter("Enumber"));
		}
		if(Enumber == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 접근입니다.')");
			script.println("location.href='QNAboard.jsp'");
			script.println("</script>");
		}
		UserDAO userdao = new UserDAO();
		
		scoreboard scoreboard = userdao.getSboard(Enumber);
		
		
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
                    <a class="nav-icon d-none d-lg-inline" href="#" data-bs-toggle="modal" data-bs-target="#templatemo_search">
                        <i class="fa fa-fw fa-search text-dark mr-2"></i>
                    </a>
                    <a class="nav-icon position-relative text-decoration-none" href="login.jsp">
                        <i class="fa fa-fw fa-user text-dark mr-3"></i>
<!--                          <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark">+99</span>
-->
                    </a>
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
							<td colspan="1" style="text-align:left">제목</td>
							<td colspan="4"><%=scoreboard.getTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
						<tr>
							<td colspan="1" style="text-align:left">작성자</td>
							<td colspan="2"><%=userdao.getNick(scoreboard.getUserID())%></td>
							<td colspan="2">별점&nbsp;&nbsp;<%=userdao.outStar(userdao.getStar(scoreboard.getUserID()))%></td>
						</tr>
						
						<tr>
							<td colspan="1" style="text-align:left">내용</td>
							<td colspan="3" style="min-height: 400px; text-align:left"><%=scoreboard.getContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
							<%
								String directory =application.getRealPath("/upload/");
								String files[] = new File(directory).list();
								String filename=userdao.getFileRealNameE(Enumber);
								String img_scr ;
								
								
								
								for(int i = 0 ; i < files.length; i++){
									filename=userdao.getFileRealNameE(Enumber);
									
									if(files[i].equals(userdao.getFileRealNameE(Enumber))){
										
										filename=userdao.getFileRealNameE(Enumber);
							%>
								<td colspan="1" ><img src="<%=request.getContextPath()%>/upload/<%=filename%>" width="300px" height="200px"></td>
							<%
									}
								}
							%>
						</tr>
					</tbody>
				</table>
				<a href="scoreboard.jsp" class="btn btn-primary">목록</a>
		</div>
	</div>
	
	<!-- Close Write -->
</html>