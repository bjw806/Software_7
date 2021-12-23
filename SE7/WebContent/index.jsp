<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDAO"%>
<%@page import="User.dicboard"%>
<%@page import="User.User"%>
<%@page import="java.io.File" %>
<%@page import="java.util.ArrayList" %>
<%@page import= "java.util.List" %>
<%@page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
    <title>테스트용 </title>
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
	<% 
		UserDAO userdao = new UserDAO(); 
		
		int pageNumber = 1;
		if(request.getParameter("pageNumber") != null){
			pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
		}
	%>
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

   

    <!-- Start Banner Hero -->
    <div id="template-mo-zay-hero-carousel" class="carousel slide" data-bs-ride="carousel">
        <ol class="carousel-indicators">
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="0" class="active"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="1"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="2"></li>
            <li data-bs-target="#template-mo-zay-hero-carousel" data-bs-slide-to="3"></li>
        </ol>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./assets/img/banner_img_01.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left align-self-center">
                                <h1 class="h1 text-success"><b>분리배출</b>4가지 원칙</h1>
                                <h3 class="h2">1. 비운다</h3>
                                <p> 용기 안에 담겨있는 내용물은 깨끗이 비워주세요.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./assets/img/banner_img_02.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h1 class="h1 text-success"><b>분리배출</b>4가지 원칙</h1>
                                <h3 class="h2">2. 헹군다</h3>
                                <p>재활 용품에 묻어 있는 이물질, 음식물등은 닦거나  <strong>꼭 헹궈서</strong> 배출합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./assets/img/banner_img_03.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h1 class="h1 text-success"><b>분리배출</b>4가지 원칙</h1>
                                <h3 class="h2">3. 분리한다</h3>
                                <p>
                                	라벨 등의 다른 재질의 부분은  제거하여 배출합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="carousel-item">
                <div class="container">
                    <div class="row p-5">
                        <div class="mx-auto col-md-8 col-lg-6 order-lg-last">
                            <img class="img-fluid" src="./assets/img/banner_img_04.jpg" alt="">
                        </div>
                        <div class="col-lg-6 mb-0 d-flex align-items-center">
                            <div class="text-align-left">
                                <h1 class="h1 text-success"><b>분리배출</b>4가지 원칙</h1>
                                <h3 class="h2">4. 섞지 않는다.</h3>
                                <p>
                                	종류별로 재질별로 구분하여 배출합니다.
                                </p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <a class="carousel-control-prev text-decoration-none w-auto ps-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="prev">
            <i class="fas fa-chevron-left"></i>
        </a>
        <a class="carousel-control-next text-decoration-none w-auto pe-3" href="#template-mo-zay-hero-carousel" role="button" data-bs-slide="next">
            <i class="fas fa-chevron-right"></i>
        </a>
    </div>
    <!-- End Banner Hero -->

    <!-- Start Categories of recycling-info -->
    
    <section class="container py-5">
        <div class="row text-center pt-3">
            <div class="col-lg-6 m-auto">
                <h1 class="h1">백과사전 정보</h1>
                
            </div>
        </div>
        <div class="row">
        	<% 
        		// Total Dicboard Post 갯수만큼 for문을 돌아서 이미지 링크 파일을 생성한다.
        		for(int i=0; i< userdao.getTotalDicboardList().size() ; i++){
        			ArrayList<dicboard> dBoardList = userdao.getTotalDicboardList();
        			if(dBoardList.get(i).getTitle() == null || dBoardList.get(i).getTitle().trim().isEmpty()){
        				System.out.println("null pointer error : dBoard값 중 타이틀이 'null' 인것이 있습니다");
        			} else{
        				
						String directory =application.getRealPath("/upload/");
						String files[] = new File(directory).list();
						String filename;
						String img_scr ;
						
						// dicboard는 이미지파일을 가지고 있는지 에대한 bool
						boolean bool=false;
						List<Integer> alreadyPrinted = new ArrayList<Integer>();
						
						
						// i 번째 Dicboard가 가지고 있는 이미지 파일을 검색
						// 있다면 메인 사진으로 사용한다.
						// 없다면 default사진 (webproject 경로)으로 대신한다.
						for(int j = 0 ; j < files.length; j++){
							filename=userdao.getFileRealNameD(dBoardList.get(i).getDnumber());
							
							if(files[j].equals(userdao.getFileRealNameD(dBoardList.get(i).getDnumber()))){
								
								filename=userdao.getFileRealNameD(dBoardList.get(i).getDnumber());
								// if문이 true면 i번째 dicboard 는 j번째 dicpicture에 있는 사진을 소유
								// bool: false -> ture
								alreadyPrinted.add(dBoardList.get(i).getDnumber());
								bool = true;
								
					
        	%>
        	<div style="width: 270px; height: 237px; " class="col-4 col-md-3 p-4 mr-3 my-5">
                <a href="dicview.jsp?Dnumber=<%=dBoardList.get(i).getDnumber()%>"><img src="<%=request.getContextPath()%>/upload/<%=filename%>" style="width: 270px; height: 237px" class="rounded-circle img-fluid border"></a>
                <h5 class="text-center mt-3 mb-3"><%=dBoardList.get(i).getTitle()%></h5>
            </div>
            <%
        				}
        			} if(!bool && !alreadyPrinted.contains(dBoardList.get(i).getDnumber()) && !dBoardList.isEmpty()){
        	%>
        			<div style="width: 270px; height: 237px " class="col-4 col-md-3 p-4 mr-3 my-5">
               			<a href="dicview.jsp?Dnumber=<%=dBoardList.get(i).getDnumber()%>"><img src="./assets/img/default.png" style="width: 270px; height: 237px" class="rounded-circle img-fluid border"></a>
                		<h5 class="text-center mt-3 mb-3"><%=dBoardList.get(i).getTitle()%></h5>
           			</div>
        	
        	<%		
        			} 
        	%>
        			
        	<%
        			
        		}
        	}
            %>	
            <div class="col-4 col-md-3 p-4 mr-3 my-5">
               			<a href="#"><img src="./assets/img/waiting.gif"></a>
                		<h5 class="서비스 준비중"></h5>
           			</div>
        </div>
    </section>
    <!-- End Categories of recycling-info -->

    <!-- Start Script -->
    <script src="assets/js/jquery-1.11.0.min.js"></script>
    <script src="assets/js/jquery-migrate-1.2.1.min.js"></script>
    <script src="assets/js/bootstrap.bundle.min.js"></script>
    <script src="assets/js/templatemo.js"></script>
    <script src="assets/js/custom.js"></script>
    <!-- End Script -->
</body>
</html>