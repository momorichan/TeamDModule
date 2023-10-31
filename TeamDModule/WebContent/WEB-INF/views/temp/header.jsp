<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@page import="java.util.*"%>
<%-- jstl을 위한 태그 라이브러리 선언 --%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">    
   <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
   <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.min.js"></script>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
</head>
<body>
	<nav class="navbar navbar-expand-sm bg-dark navbar-dark">
		<div class="container-fluid">
			<a class="navbar-brand" href="#">쇼핑몰</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#collapsibleNavbar">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="collapsibleNavbar">
				<ul class="navbar-nav">
					<li class="nav-item">
					</li>
					<!-- product section -->
					<li class="nav-item dropdown">
						<a class="nav-link dropdown-toggle" href="#" role="button"
							data-bs-toggle="dropdown">상품</a>
						<ul class="dropdown-menu">
							
							<li><a class="dropdown-item" href="prList">목록 보기</a></li>
						</ul>
					</li>		
			        <!-- 쇼핑몰 section -->
			        <li class="nav-item dropdown">
			          <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">쇼핑몰</a>
			          <ul class="dropdown-menu">          
			            <li>
			            	<a class="dropdown-item" href="maList">
			            		카트 내역 보기
			            	</a>
			            </li>
<!-- 			            <li> -->
<%-- 			            	<a class="dropdown-item" href="<%=notWithFormTag%>maHistory"> --%>
<!-- 			            		나의 쇼핑 내역 -->
<!-- 			            	</a> -->
<!-- 			            </li> -->
			          </ul>
			        </li> 					
				</ul>
			</div>
		</div>
	</nav>
</body>
</html>
