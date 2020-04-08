<!DOCTYPE html>
<html lang="en" >

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ page language="java" contentType="text/html; charset=utf-8" 
	pageEncoding="utf-8"%>
<head>
<meta charset="utf-8" />
  <!--   Core JS Files   -->
 
  <script src="../../assets/js/core/popper.min.js"></script>
<script src="../../assets/js/core/jquery.min.js"></script>
<script src="../../assets/js/core/bootstrap.min.js"></script>
 <script src="../../assets/js/plugins/perfect-scrollbar.jquery.min.js"></script>
 
 <!-- Chart JS -->
  <script src="../../assets/js/plugins/chartjs.min.js"></script>
  <!--  Notifications Plugin    -->
  <script src="../../assets/js/plugins/bootstrap-notify.js"></script>
  <!-- Control Center for Now Ui Dashboard: parallax effects, scripts for the example pages etc -->
  <script src="../../assets/js/paper-dashboard.min.js?v=2.0.0" type="text/javascript"></script>
  
<link rel="apple-touch-icon" sizes="76x76"
	href="../assets/img/apple-icon.png">
<link rel="icon" type="image/png" href="../assets/img/favicon.png">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>농구할래?!</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css"
	rel="stylesheet">
<!-- CSS Files -->
<link href="../../assets/css/bootstrap.min.css" rel="stylesheet" />
<link href="../../assets/css/paper-dashboard.css?v=2.0.0"
	rel="stylesheet" />

</head>
<body class="wrapper">
	<div class="wrapper-full-page">
		<div class="sidebar" data-color="blue" data-active-color="danger">
			<!--
        Tip 1: You can change the color of the sidebar using: data-color="blue | green | orange | red | yellow"
    -->
    	<sec:authentication property="principal" var="customUser" />
			<sec:authorize access="isAuthenticated()">
			<div class="logo">
				<a href="/member/user" class="simple-text logo-mini">
					<i class="logo-image-small"><img src="../../assets/img/default-avatar.png">
					</i>	
				</a>
				<a href="/member/user">
				  	<p>${customUser.member.id}<br>
					<c:choose>
						<c:when test="${customUser.member.position eq '1'}">
						point guard
						 </c:when>
						<c:when test="${customUser.member.position eq '2'}">
						shooting guard
						 </c:when>
						 <c:when test="${customUser.member.position eq '3'}">
						power forward
						 </c:when>
						 <c:when test="${customUser.member.position eq '4'}">
						small forward
						 </c:when>
						 <c:when test="${customUser.member.position eq '5'}">
						center
						 </c:when>
						<c:otherwise> 
						no position registered
						 </c:otherwise>
					</c:choose>
					</p>  
				</a>
			</div>
			</sec:authorize>
			<div class="sidebar-wrapper">
				<ul id="sidebar" class="nav">
					<li id="board">
					<a href="/board/list">
						<i class="nc-icon nc-bullet-list-67"></i>
						<p>Board</p>
					</a></li>
					<li id="Maps">
					<a href="/map/map"> <i class="nc-icon nc-pin-3"></i>
							<p>Maps</p>
					</a></li>
					
					<li id="Team">
					<a href="/team/list"> 
					<i class="nc-icon nc-single-02"></i>
							<p>Team</p>
					</a></li>
				</ul>
			</div>
			
		</div>
		<div class="main-panel" style="background-image: url('../../assets/img/nba.jpg');">
			<!-- Navbar -->
			<nav class="navbar navbar-expand-lg navbar-absolute fixed-top navbar-transparent">
				<div class="container-fluid">
					<div class="navbar-wrapper">
						<div class="navbar-toggle">
							<button type="button" class="navbar-toggler">sc
								<span class="navbar-toggler-bar bar1"></span> <span
									class="navbar-toggler-bar bar2"></span> <span
									class="navbar-toggler-bar bar3"></span>
							</button>
						</div>
					</div>
					<button class="navbar-toggler" type="button" data-toggle="collapse"
						data-target="#navigation" aria-controls="navigation-index"
						aria-expanded="false" aria-label="Toggle navigation">
						<span class="navbar-toggler-bar navbar-kebab"></span> <span
							class="navbar-toggler-bar navbar-kebab"></span> <span
							class="navbar-toggler-bar navbar-kebab"></span>
					</button>
					<div class="collapse navbar-collapse justify-content-end"
						id="navigation">
						
						<ul class="navbar-nav">
						<!-- 로그인 안된 상태 -->
							<sec:authorize access="isAnonymous()">
								<button type="button" class="btn-kk" onclick="location.href='/call/customLogin' ">로그인</button> 
								<button type="button" class="btn-primary btn-kk" onclick="location.href='/call/log/register' ">회원가입</button>
								
							</sec:authorize>
							<!-- 로그인된 상태 -->
							<sec:authentication property="principal" var="customUser" />
							<sec:authorize access="isAuthenticated()">
								<button type="button" class="btn-kk" onclick="location.href='/customLogout' ">로그아웃</button>
								<button type="button" class="btn-kk" onclick="location.href='/call/log/signoff' ">회원탈퇴</button>
								<button type="button" class="btn-kk" onclick="location.href='/member/user' ">profile</button>
							</sec:authorize>
						</ul>
					</div>
				</div>
			</nav>
			<!-- End Navbar -->
			<div class="content" >