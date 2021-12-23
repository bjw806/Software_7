<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDAO"%>
<%@page import="User.qboard"%>
<%@page import="User.User"%>
<%@page import="User.dicboard" %>
<%@page import="java.util.ArrayList" %>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
    <title>백과사전</title>
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
    
    <style type="text/css">
    	a, a:hover {
    		color: #000000;
    		text-decoration: none;
    	}
    </style>
    
	<% 
		UserDAO userdao = new UserDAO(); 
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
</head>

<body>
	<%
		//세션체크
		String userid = null;
		if(session.getAttribute("userid") != null){
			userid = (String)session.getAttribute("userid");
		}
	%>
    <!-- Start Top Nav -->
    <nav class="navbar navbar-expand-lg bg-dark navbar-light d-none d-lg-block" id="templatemo_nav_top">
        <div class="container text-light">
            <div class="w-100 d-flex justify-content-between">
 
            </div>
        </div>
    </nav>
    <!-- Close Top Nav -->
    
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
	
	<!-- Start Banner -->
    <section class="container">
        <div class="container">
            <div class="row align-items-center py-5">
                <div class="col-md-8">
                    <h1>백과사전게시판</h1>
                    <p>
                    </p>
                </div>
                <div class="col-md-4">
                    <img src="assets/img/about-hero.svg" alt="About Hero">
                </div>
            </div>
        </div>
    </section>
    <!-- Close Banner -->

    <!-- Modal -->
    <div class="modal fade bg-white" id="templatemo_search" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-lg" role="document">
            <div class="w-100 pt-1 mb-5 text-right">
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="" method="get" class="modal-content modal-body border-0 p-0">
                <div class="input-group mb-2">
                    <input type="text" class="form-control" id="inputModalSearch" name="q" placeholder="Search ...">
                    <button type="submit" class="input-group-text bg-success text-light">
                        <i class="fa fa-fw fa-search text-white"></i>
                    </button>
                </div>
            </form>
        </div>
    </div>
	
    <!-- Start Content -->
    <div class="container py-5">
        <div class="row">
        <!-- Search -->
        	<form action="searchd.jsp">
				<div align="right">
					<select id="searchoption" name="searchoption">
						<option value="Title">제목에서</option>
						<option value="UserID">작성자에서</option>
					</select>
				<input type="text" id="searchtext" name="searchtext" size=10>
				<input type="submit" class="btn btn-primary pull-right" value="검색">
				</div>
			</form>
		<!-- End Search -->
			<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
				<thead>
					<tr>
						<th style="background-color: #eeeeee; text-align: center;">번호</th>
						<th style="background-color: #eeeeee; text-align: center;">제목</th>
						<th style="background-color: #eeeeee; text-align: center;">작성자</th>
					</tr>
				</thead>
				<tbody>
						<% 
							ArrayList<dicboard> dicboardList = userdao.getDboardList(pageNumber);
							for(int i = 0; i < dicboardList.size() ;i++)
							{
						%>
						<tr>
						<td><%=dicboardList.get(i).getDnumber()%></td>
						<td><a href="dicview.jsp?Dnumber=<%=dicboardList.get(i).getDnumber()%>"><%=dicboardList.get(i).getTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></a></td>
						<td><%=userdao.getNick(dicboardList.get(i).getUserID())%></td>
						</tr>
						<%
							}
						%>
					
				</tbody>
			</table>
			<!-- 페이지 버튼 생성 -->
			<div align="left">
			<% 
				if(pageNumber != 1){
			%>
				<a href="dicboard.jsp?pageNumber=<%=pageNumber - 1 %>" class="btn btn-success btn-arrow-left">이전</a>
			<%
				}for(int i=0; i <10 ; i++){
					if(userdao.endDicPage(pageNumber) < userdao.stratPage(pageNumber)+i){
						break;
					}
			%>
				<a href="dicboard.jsp?pageNumber=<%=userdao.stratPage(pageNumber)+i%>" class="btn btn-outline-dark"><%=userdao.stratPage(pageNumber)+i %></a>
			
			<%
				} if(userdao.nextPage(pageNumber+1)){
			%>
				<a href="dicoard.jsp?pageNumber=<%=pageNumber + 1 %>" class="btn btn-success btn-arrow-left">다음</a>
			<%
				}
			%>
			<%	
				
				// 1 관리자
				if(userdao.getRole(userid) == 1){
			%>
			<a href="write_dic.jsp" class="btn btn-primary pull-right">글쓰기</a>
			<%
				}
			%>
			
			</div>
		</div>
    </div>
   

    <!-- Start Script -->
    <script src="assets/js/jquery-1.11.0.min.js"></script>
    <script src="assets/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/templatemo.js"></script>
    <script src="assets/js/custom.js"></script>
    <!-- End Script -->
</body>
</html>