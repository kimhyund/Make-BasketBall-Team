<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>
<div class="row">
	<div class="col-lg-12">
		<h2>게시글 수정</h2>
	</div>
</div>

<div class="row" style="background: #ffffff; padding: 25px; border-radius: 10px;">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">신규 게시글</div>
			<div class="panel-body">
				<form id="boardForm" role="form" action="update.do" method="post">
					<div class="form-group">
						<label>Bno : </label>
						<input class="form-control" type="text" name="bno" 
						value='<c:out value="${board.bno}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>제목 : </label>
						<input class="form-control" type="text" name="title" 
						value='<c:out value="${board.title}"/>' >
					</div>
					<div class="form-group">
						<label>작성자 : </label>
						<input class="form-control" type="text" name="writer" 
						value='<c:out value="${board.writer}" />' >
					</div>
					<div class="form-group">
						<label>내용 : </label>
						<textarea class="form-control" name="content" rows="4" cols="50"><c:out value="${board.content}"/>
						</textarea>
					</div>

					<button type="submit" data-oper='modify' class="btn btn-default">수정</button>
					<button type="submit" data-oper="remove" class="btn btn-danger">삭제</button>
					<button type="submit" data-oper="list" class="btn btn-info">List</button>
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
<%@include file="../fileUpload/uploadAjax.jsp" %>
<%@include file="../includes/footer.jsp" %>
	
<script type="text/javascript">
$(document).ready(function(){
	setOperationMode("modify");
	var masterName = '<c:out value="${masterName}"/>';

	//Json Message를 EL 표현으로 해석하여 객체 생성 
	var jsonOfAttachList = ${board.jsonOfListAttach};

	showUploadedFile(jsonOfAttachList);

	var boardForm = $("#boardForm");
	$("#boardForm button").on("click", function(e){
		e.preventDefault();
		
		var oper = $(this).data("oper");
		
		if (oper === "remove") {
			boardForm.attr("action", "deletePosting");
		} else if (oper === "list") {
			//self.location = "/board/list";
			//return;
			boardForm.attr("action", "/board/list").attr("method", "get");
			
			var inputPN = $("input[name='pageNum']").clone();
			var inputAmt = $("input[name='amount']").clone();
			var inputSt = $("input[name='searchType']").clone();
			var inputK = $("input[name='keyword']").clone();
			boardForm.empty();
			boardForm.append(inputPN);
			boardForm.append(inputAmt);
			boardForm.append(inputSt);
			boardForm.append(inputK);
		} else if (oper === "modify") {
			var strRemainingAttaches = gatherRemainingAttaches(masterName);
			boardForm.append(strRemainingAttaches);
		}
		boardForm.submit();
	});
});
</script>
	
	
	
	
	
	
	
	
	