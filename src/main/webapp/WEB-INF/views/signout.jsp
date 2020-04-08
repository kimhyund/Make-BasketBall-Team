<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>

<%@include file="../views/includes/header.jsp"%>

<form id="signoutForm" action="/member/deleteMember" method="post">
	 <h3><strong>회원탈퇴</strong></h3>
	 <div class="form-group" id="divId">
		<div class="col-lg-7">
			<input type="text" class="form-control" name="id" placeholder="아이디" maxlength="12">
		</div>
		<div class="form-group" id="divPassword">
		<div class="col-lg-7">
			<input type="password" class="form-control" name="password" placeholder="패스워드" maxlength="12">
		</div>
		<div class="form-group">
		<div class="col-lg-offset-2 col-lg-10">
			<button data-oper='signout' class="btn btn-default">signout</button>
			
		</div>
		<div class="col-lg-7">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</div>
	</div>
	</div>
    </div>
</form >

<script type="text/javascript">
$(document).ready(function(){
	var signoutForm = $("#signoutForm");

	$("button").on("click", function(e){
		e.preventDefault();
		
		signoutForm.submit();
	});
});
</script>


