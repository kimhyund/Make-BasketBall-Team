	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

  <link href="../assets/css/teamRegistry.css" rel="stylesheet" type="text/css">


<div class="row" style="background: #ffffff; padding: 25px; border-radius: 10px;">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">팀 관리</div>
			<div class="panel-body">
<!-- 			<form id = "teamModify" role = "form" action="update.do" method = "post">   -->
				<form id = "team" role = "form"> 
					<div class="form-group">
						<label>team name : </label>
						<input class="form-control" type="text" name="teamName" 
						value='<c:out value="${team.teamName}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>team member : </label>
						<input class="form-control" type="text"
						value='<c:out value="${memberList}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>description : </label>
						<input class="form-control" type="text" name="description" 
						value='<c:out value="${team.description}" />'>
					</div>
					<button id = "modify" type="submit" data-oper='modify' class="btn btn-default">수정</button>
					<button id = "remove" type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
					<button id = "list" type="submit" data-oper="list" class="btn btn-info">List</button>
					<div class="col-lg-7">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
					</div>
					<input type="hidden" name='pageNum' value='${pageMaker.pageNum}'>
					<input type="hidden" name='amount' value='${pageMaker.amount}'>
					<input type="hidden" name="searchType" value='<c:out value="${pageMaker.searchType}" />'>
					<input type="hidden" name="keyword" value='<c:out value="${pageMaker.keyword}" />'>
				</form>
			</div>
		</div>
	</div>
</div>



<%@include file="../includes/footer.jsp" %>
<script type="text/javascript" 	src="/assets/js/team-register.js">
</script>
<script type="text/javascript">


	var formObj = $("form[role='form']");
	
	$("#modify").click(function(){
	
		formObj.attr("action", "update.do")
		formObj.attr("method", "post");
		formObj.submit();
	});
	
	$("#remove").click(function(){
		
		formObj.attr("action", "deleteTeam")
		formObj.attr("method", "post");
		formObj.submit();
	});


</script>	
	

	