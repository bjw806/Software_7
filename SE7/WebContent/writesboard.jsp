<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.io.PrintWriter"%>
<%@page import="User.UserDAO"%>
<%@page import="User.User"%>

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
			<form method="post" action="act_sbwrite.jsp" enctype="multipart/form-data">
				<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th colspan="10" style="background-color: #eeeeee; text-align: center;">평가 게시판</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td  style="border: none; width:80%"><input type="text" class="form-control" placeholder="글 제목" name="Title" maxlength="50"></td>
							<td style="width:20%">
								<label>평점 : </label>
								<select id="Star" name="Star">
									<option value="0">☆☆☆☆☆</option>
									<option value="1">★☆☆☆☆</option>
									<option value="2">★★☆☆☆</option>
									<option value="3">★★★☆☆</option>
									<option value="4">★★★★☆</option>
									<option value="5">★★★★★</option>
								</select>
							</td>
						</tr>
						<tr>
							<td colspan="8"><textarea class="form-control" placeholder="글 내용 (500자 이내)" name="Content" maxlength=500 style="height: 350px;"></textarea></td>
							<td colspan="2"><a id='View_area' style='position:relative; width: 200px; height: 150px; color: black; border: 0px solid black; dispaly: inline; '>미리보기</a></td>
						</tr>
					</tbody>
				</table>
	<!-- Close Write -->
	
	<!-- Sample image -->
				<input type="file" name="file" id="file" onchange="previewImage(this,'View_area')">
				<div id='View_area' style='position:relative; width: 200px; height: 150px; color: black; border: 0px solid black; dispaly: inline; '></div>
	<!-- Close Sample image -->
				<div  align="right">
				<!-- 취소버튼 -->
				<input type="button" class="btn btn-primary pull-left" OnClick="javascript:history.back(-1)" value="취소">
				<!-- 글쓰기 버튼 생성 -->
				<input type="submit" class="btn btn-primary pull-right" value="글쓰기">
				</div>
				
				<!-- 이미지 미리보기 script -->
				<script type="text/javascript">
				function previewImage(targetObj, View_area) {
					var preview = document.getElementById(View_area); //div id
					var ua = window.navigator.userAgent;
				  //ie일때(IE8 이하에서만 작동)
					if (ua.indexOf("MSIE") > -1) {
						targetObj.select();
						try {
							var src = document.selection.createRange().text; // get file full path(IE9, IE10에서 사용 불가)
							var ie_preview_error = document.getElementById("ie_preview_error_" + View_area);
							if (ie_preview_error) {
								preview.removeChild(ie_preview_error); //error가 있으면 delete
							}
							var img = document.getElementById(View_area); //이미지가 뿌려질 곳
							//이미지 로딩, sizingMethod는 div에 맞춰서 사이즈를 자동조절 하는 역할
							img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='"+src+"', sizingMethod='scale')";
						} catch (e) {
							if (!document.getElementById("ie_preview_error_" + View_area)) {
								var info = document.createElement("<p>");
								info.id = "ie_preview_error_" + View_area;
								info.innerHTML = e.name;
								preview.insertBefore(info, null);
							}
						}
				  //ie가 아닐때(크롬, 사파리, FF)
					} else {
						var files = targetObj.files;
						for ( var i = 0; i < files.length; i++) {
							var file = files[i];
							var imageType = /image.*/; //이미지 파일일경우만.. 뿌려준다.
							if (!file.type.match(imageType))
								continue;
							var prevImg = document.getElementById("prev_" + View_area); //이전에 미리보기가 있다면 삭제
							if (prevImg) {
								preview.removeChild(prevImg);
							}
							var img = document.createElement("img"); 
							img.id = "prev_" + View_area;
							img.classList.add("obj");
							img.file = file;
							img.style.width = '200px'; 
							img.style.height = '150px';
							preview.appendChild(img);
							if (window.FileReader) { // FireFox, Chrome, Opera 확인.
								var reader = new FileReader();
								reader.onloadend = (function(aImg) {
									return function(e) {
										aImg.src = e.target.result;
									};
								})(img);
								reader.readAsDataURL(file);
							} else { // safari is not supported FileReader
								//alert('not supported FileReader');
								if (!document.getElementById("sfr_preview_error_"
										+ View_area)) {
									var info = document.createElement("p");
									info.id = "sfr_preview_error_" + View_area;
									info.innerHTML = "not supported FileReader";
									preview.insertBefore(info, null);
								}
							}
						}
					}
				}
				</script>
				<!-- 미리보기 script 끝 -->
				
				
			</form>
		</div>
	</div>
	<!-- Close Write -->
</body>
</html>