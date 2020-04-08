<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>


<div class="card card-plain">
	<div class="row" style="background: #ffffff; padding: 25px; border-radius: 10px;">
	 <div class="card-body">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">신규 게시글</div>
			<div class="panel-body">
				<form role="form" action="insert.do" method="post">
					<div class="form-group">
						<label>제목 : 
						</label><input class="form-control" type="text" name="title">
					</div>
					<div class="form-group">
						<label>type : 
						</label><input class="form-control" type="text" name="type"
						value="${type}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>address : 
						</label><input class="form-control" type="text" name="address"
						value="${address}" readonly="readonly">
					</div>
					<div class="form-group">
						<label>작성자 : </label><input class="form-control" type="text" name="writer"
						value='<sec:authentication property="principal.member.id"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
						<label>내용 : </label><textarea class="form-control" name="content" rows="4" cols="50"></textarea>
					</div>
				<input id='registPost' class="btn btn-default" type="submit" value="등록">
					<input class="btn btn-default" type="reset" value="초기화">
				</form>
			</div>
		</div>
	</div>
	</div>
</div>
</div>
<%@include file="../fileUpload/uploadAjax.jsp" %>
<%@include file="../includes/footer.jsp" %>

<script>
$(document).ready(function() {
	var formObj = $("form[role='form']");

	var masterName = '<c:out value="${masterName}"/>';
	setOperationMode("create");
	
	$("#registPost").on("click", function(e){
		e.preventDefault();
		
		var strRemainingAttaches = gatherRemainingAttaches(masterName);
		console.log("123"+strRemainingAttaches);
		formObj.append(strRemainingAttaches);
		console.log(formObj);
		formObj.submit();
	});

});
</script>
	