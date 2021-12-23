<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="User.UserDAO"%>
<%@ page import="User.*"%>
<%@ page import="java.io.PrintWriter"%>
<% request.setCharacterEncoding("utf-8"); %>
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
		
		String title = request.getParameter("title");
		String nick = request.getParameter("nick");
		String content= request.getParameter("content");
		int Qnumber = Integer.parseInt(request.getParameter("Qnumber"));
		
	%>
	<script>
  		function openCloseToc() {
   		 if(document.getElementById('toc-content').style.display === 'block') {
    		document.getElementById('toc-content').style.display = 'none';
      		document.getElementById('toc-toggle').textContent = '질문글 열기';
   		 } else {
    		  document.getElementById('toc-content').style.display = 'block';
     		 document.getElementById('toc-toggle').textContent = '질문글 닫기';
   		 }
  }
</script>
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
<!--                          <span class="position-absolute top-0 left-100 translate-middle badge rounded-pill bg-light text-dark">+99</span>
-->
                    </a>
                </div>
            </div>

        </div>
    </nav>
    <!-- Close Header -->
    
    <!-- Q view -->
   <div id="toc-content">
    <div class="container">
		<div class="row">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;"><%=title%></th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>글작성자</td>
							<td colspan="2"><%=nick%></td>
						</tr>
						<tr>
							<td colspan="2" style="text-align:left"><%=content%></td>
						</tr>
							
					</tbody>
					
				</table>
			
		</div>
	</div>
	
</div>
    <!-- Close Q view -->
    
    <!-- Write -->
	<div class="container">
		<div class="row" >
			<form method="post" action="act_AnswerWrite.jsp">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="2" style="background-color: #eeeeee; text-align: center;">Q&amp;A 답변</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="Title" maxlength="50"></td>
						</tr>
						<tr>
							<td><textarea class="form-control" placeholder="글 내용 (500자 이내)" name="Content" maxlength=500 style="height: 350px;"></textarea></td>
						</tr>
					
							
					</tbody>
					
				</table>
				<input type="hidden" name="Qnumber" value="<%=Qnumber%>">
				
				
				<div  align="right">
				<!-- 취소버튼 -->
				<input type="button" class="btn btn-primary pull-left" OnClick="javascript:history.back(-1)" value="취소">
				<!-- 질문글 여닫기 -->
				<button type="button" id="toc-toggle" onclick="openCloseToc()" class="btn btn-primary" data-toggle="collapse" data-target="#qview">질문글 닫기</button>
				
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="답변등록">
				</div>
			</form>
		</div>
	</div>
	<!-- Close Write -->