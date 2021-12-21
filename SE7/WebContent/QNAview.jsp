<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="dao.DAO"%>
<%@page import="beans.qboard"%>
<%@page import="beans.user"%>
<%@page import="java.io.File" %>

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
	
		int Qnumber =0;
		if (request.getParameter("Qnumber") != null){
			Qnumber = Integer.parseInt(request.getParameter("Qnumber"));
		}
		if(Qnumber ==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 접근입니다.')");
			script.println("location.href='QNAboard.jsp'");
			script.println("</script>");
		}
		DAO dao = new DAO();
		dao.connect();
		qboard qboard= dao.getQboard(Qnumber);
		
		String title = qboard.getTitle();
		String content =qboard.getContent();
		
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
                            <a class="nav-link" href="index.jsp">분리수거</a>
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
							<th colspan="3" style="background-color: #eeeeee; text-align: center;">게시글</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td style="width: 20%;">제목</td>
							<td colspan="2"><%=qboard.getTitle().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
						<tr>
							<td>글작성자</td>
							<td colspan="2"><%=dao.getNick(qboard.getUserID())%></td>
						</tr>
						<tr>
							<td>내용</td>
							<td colspan="2" style="min-height: 200px; text-align:left"><%=qboard.getContent().replaceAll(" ","&nbsp;").replaceAll("<","&lt;").replaceAll(">", "&gt;").replaceAll("\n", "<br>")%></td>
						</tr>
						
						
					</tbody>
				</table>
				<%
								String directory =application.getRealPath("/upload/");
								String files[] = new File(directory).list();
								String filename=dao.getFileRealName(Qnumber);
								String img_scr ;
								
								
								
								for(int i = 0 ; i < files.length; i++){
									filename=dao.getFileRealName(Qnumber);
									
									if(files[i].equals(dao.getFileRealName(Qnumber))){
										;
										filename=dao.getFileRealName(Qnumber);
							%>
								<a><img src="<%=request.getContextPath()%>/upload/<%=filename%>" width="400px" height="300px"></a>
							<%
									}
								}
							%>
		</div>
		<div class="row" align="right" style="float: right;">
			<a href="QNAboard.jsp"  class="btn btn-primary" style="width: 100px; hieght: 41px;">목록</a>
			<%
				// 관리자(admin) 0 
				if(dao.getRole(userid) == 0){
			%>
				<form action="AsnwerBoard.jsp" style="width: 100px; hieght: 48px;" method="post" accept-charset="UTF-8">
					<input type="hidden" name="title" type="text" value="<%=title%>"/>
					<input type="hidden" name="nick" value="<%=dao.getNick(qboard.getUserID())%>" type="text"/>
					<input type="hidden" name="content" value="<%=content%>" type="text"/>
					<input type="hidden" name="Qnumber" value="<%=Qnumber%>" type="text"/>
					<button type="submit"  class="btn btn-primary" style="width: 100px; hieght: 44px;">답변등록</button>
				</form>
			<%
				}
			%>
			
		</div>
	</div>
				
	<!-- Close Write -->
</html>