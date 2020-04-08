<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>

<%@include file="../views/includes/StarterStyle.jsp"%>
	<div class="login">
		 <div class="box">
	          <div class="content">
             	<div class="forgot">
             	${error}
             	</div>
             </div>
	     </div>
	     <div class="box">
	     	<form id="loginForm" action="/login" method="post">
	     		<div class="form">
					<input type="text" class="form-control" name="username" placeholder="아이디" maxlength="12">
					<input type="password" class="form-control" name="password" placeholder="패스워드" maxlength="12">
					<div class="form-group">
						<button type="submit" data-oper='login' class="btn btn-login">로그인</button>
						<button type="submit" data-oper='register' class="btn btn-login" >회원가입</button>
						<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					</div>
				</div>
			</form >
	     </div> 
	</div>
<script type="text/javascript">
$(document).ready(function(){
	var loginForm = $("#loginForm");

	$("button").on("click", function(e){
		e.preventDefault();
		var oper = $(this).data("oper");
		if (oper === "register") {
			loginForm.attr("action", "call/log/register").attr("method", "get");
		}
		loginForm.submit();
	});
});
</script>


