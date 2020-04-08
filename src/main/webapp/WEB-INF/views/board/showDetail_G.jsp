<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<sec:authentication property="principal" var="customUser"/>
<div class="row" style="background: #ffffff; padding: 25px; border-radius: 10px;">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">신규 게시글</div>
			<div class="panel-body">
					<div class="form-group">
						<input class="form-control" type="hidden" name="bno" 
						value='<c:out value="${board.bno}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>type : </label>
						<input class="form-control" type="text" name="title" 
						value='<c:out value="${board.type}"/>' readonly="readonly">
					</div>
					<div class="form-group">
						<label>제목 : </label>
						<input class="form-control" type="text" name="title" 
						value='<c:out value="${board.title}"/>' readonly="readonly">
					</div>
					
					<div class="form-group">
						<label>작성자 : </label>
						<input class="form-control" type="text" name="writer" 
						value='<c:out value="${board.writer}" />' readonly="readonly">
					</div>
					<div class="form-group">
						<label>플레이 장소 : </label>
						<input class="form-control" type="text" name="writer" 
						value='<c:out value="${board.address}"/>'>
					</div>
					<div class="form-group">
						<label>내용 : </label>
						<textarea class="form-control" name="content" rows="4" cols="50"><c:out value="${board.content}"/>
						</textarea>
					</div>
					<sec:authorize access="isAuthenticated()">
					<c:if test="${customUser.member.id eq board.writer}">
						<button data-oper='modify' class="btn btn-default">수정</button>
					</c:if>
					</sec:authorize>
					<button data-oper='list' class="btn btn-info">목록</button>
					
					<!-- 264쪽 : 나중에 다양한 상황처리 -->
					<form id="operForm" method="get">
						<input type="hidden" id="bno" name="bno" value='<c:out value="${board.bno}" />'>
						<input type="hidden" name='pageNum' value='${pageMaker.pageNum}'>
						<input type="hidden" name='amount' value='${pageMaker.amount}'>
						<input type="hidden" name="searchType" value='<c:out value="${pageMaker.searchType}" />'>
						<input type="hidden" name="keyword" value='<c:out value="${pageMaker.keyword}" />'>
					</form>
			</div>
		</div>
		<%@include file="../fileUpload/attachFile.jsp" %>
		<!-- 댓글 조회 수정 삭제 -->
		<div class="col-md-12">
			<div class="card card-plain">
			<div class="card-header">
				<i class="fa fa-comments fa-fw"></i>댓글목록<br>
			</div>
			<sec:authorize access="isAnonymous()">
			<button class="btn-success btn-simple" onclick="location.href='/customLogin'">댓글을 달기 위해선 로그인이 필요합니다</button>
		</sec:authorize>
		
		<sec:authorize access="isAuthenticated()">
			<div class="card-header">
			<button id='addReplyBtn' class='btn-primary btn-simple pull-right'>댓글달기</button>
			</div>
			
			<div data-rno="" data-bno="" id="replyForm" style="display:none">
				<div class="modal-body">
					<div class="form-group">
						<label>Reply</label> <input class="form-control" name='reply'
							value='' >
					</div>
					<div class="form-group">
						<label>Replyer</label> <input class="form-control" name='replyer'
							value='${customUser.member.id}' type="text" readonly="readonly">
					</div>
						<div class="form-group">
							<label>Reply Date</label> <input class="form-control"
								name='replyDate' value=''>
						</div>
				</div>
					<div class="modal-footer">
						<button id='modalModBtn' type="button" class="btn btn-warning">Modify</button>
						<button id='modalRemoveBtn' type="button" class="btn btn-danger">Remove</button>
						<button id='modalRegisterBtn' type="button" class="btn btn-primary">Register</button>
						<button id='modalCloseBtn' type="button" class="btn btn-default">Close</button>
						<div class="col-lg-7">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</div>
					</div>
			</div>
			</sec:authorize>
			<!-- 댓글 목록 -->
			<div class="card-body">
					<ul id="replyListDisplay">
						
					</ul>
			</div>
			
		</div>
		<div id='replyPageFooter'>
		</div>
	</div>
</div>
</div>
<%@include file="../includes/footer.jsp" %>
<!-- ?20191202 변경 시 재로드를 위하여 -->
<script type="text/javascript" src="/assets/js/replyClientService.js?2019120201" >
</script>
	
<script type="text/javascript">
$(document).ready(function(){
	
	var bnoVal = '<c:out value="${board.bno}" />';
	var ul4List = $("#replyListDisplay");
	var PAGE_SIZE = 5;
	var jsonOfAttachList =${board.jsonOfListAttach};
	var curPageNum = 1;
	showReplyList(curPageNum);
	

	showAttachFileList(jsonOfAttachList);
	function showReplyList(targetPage){
		replyClientService.getList({
			bno : bnoVal,
			page : targetPage || 1,
			pageSize : PAGE_SIZE
		},	function (listWithTotCnt){
			var totCnt = listWithTotCnt.first;
			var list = listWithTotCnt.second;
			var liHtml = "";
			//-1은 마지막 페이지 목록 조회를 처리하기
			if (targetPage == -1) {
				targetPage = Math.ceil(totCnt / (PAGE_SIZE * 1.0));
				showReplyList(targetPage);
				return;
			}
			for(var i = 0, len = list.length || 0; i < len; i++){
				liHtml += "<li class='left clear-fix' data-rno='" + list[i].rno + "' data-bno='" + list[i].bno + "'>";
				liHtml += "<div><div class='header'><strong class='primary-font'>";
				liHtml += list[i].replyer;
				liHtml += "</strong><small class='pull-right text-muted'>";
				liHtml += replyClientService.displayTime(list[i].updatedate);
				liHtml += "</small></div><p>";
				liHtml += list[i].content;
				liHtml += "</p></div></li>";
		
			}
			ul4List.html(liHtml);
			showReplyPageFooter(totCnt);
		}, function(er){
			alert("error" + er);
		});
	}
	//댓글 페이징 네이터 처리하기
	var replyPageFooter = $("#replyPageFooter");
	function showReplyPageFooter(totCnt) {
		var endPage = Math.ceil(curPageNum / (PAGE_SIZE * 1.0)) * PAGE_SIZE;
		var startPage = endPage - PAGE_SIZE + 1 ;
		var realEnd = Math.ceil(totCnt / (PAGE_SIZE * 1.0));
		endPage = realEnd < endPage ? realEnd : endPage;
		var hasPrev = startPage > 1;
		var hasNext = realEnd > endPage;
		
		var str4PageNav = "<ul class='pagination pull-right'>";
		if (hasPrev) {
			str4PageNav +="<li class='page-item'><a class='page-link' href='" + (startPage - 1) + "'>Prev</a></li>"; 
		}
		
		for (var i = startPage; i <= endPage; i++) {
			var isActive = curPageNum == i ? "active" : "";
			str4PageNav +="<li class='page-item " + isActive + "'><a class='page-link' href='" + i + "'>" + i + "</a></li>"; 
		}
		
		if (hasNext) {
			str4PageNav +="<li class='page-item'><a class='page-link' href='" + (endPage + 1) + "'>Next</a></li>"; 
		}
		
		str4PageNav += "</ul>";
		
		replyPageFooter.html(str4PageNav);
	}
	//댓글의 페이징에서 클릭하여 해당 페이지로 가기 기능
	replyPageFooter.on("click", "li a", function(e){
		e.preventDefault();

		curPageNum = $(this).attr("href");
		showReplyList(curPageNum);
	});
	
	//댓글 입력 창 띄우기
	var replyDiv = $("#replyForm");
	var modalInputReplyDate = replyDiv.find("input[name='replyDate']");
	var modalRegisterBtn = $("#modalRegisterBtn");
	var modalModBtn = $("#modalModBtn");
	var modalRemoveBtn = $("#modalRemoveBtn");
	var modalCloseBtn = $("#modalCloseBtn");
	$("#addReplyBtn").on("click", function(e) {
		//replyDiv.find("input").val("");	//청소작업
		modalInputReplyDate.closest("div").hide();
		replyDiv.find("button[id != 'modalCloseBtn']").hide();
		
		modalRegisterBtn.show();

		$("#replyForm").show();
	});
	
	var modalInputReplyContent = replyDiv.find("input[name='reply']");
	var modalInputReplyer = replyDiv.find("input[name='replyer']");
	//댓글 등록
	modalRegisterBtn.on("click", function(e){
		var reply = {
				bno:bnoVal,
				content:modalInputReplyContent.val(),
				replyer:modalInputReplyer.val()
		};
		replyClientService.add(
				reply,
				function(result) {
					alert("Result : " + result);
					
					replyDiv.find("input:first").val("");	//청소작업
					replyDiv.hide();
					//추가한 결과를 목록으로 확인할 수 있도록 재조회
					showReplyList(-1);
				},
				function(er) {
					alert("Error : " + er);
				});
	});
	
	//댓글 수정 삭제 상세조회를 위한 창 띄우기
	$("#replyListDisplay").on("click", "li", function(e){
		var rno = $(this).data("rno");
		replyClientService.get(
				rno,
				function(data) {
					//수정하고자하는 댓글을 클릭하면 정보를 DB에서 읽어 각 속성들을 채우고
					modalInputReplyContent.val(data.content);
					modalInputReplyer.val(data.replyer).attr("readonly", "readonly");;
					modalInputReplyDate.val(replyClientService.displayTime(data.regdate)).attr("readonly", "readonly");
					replyDiv.data("rno", data.rno);
					replyDiv.data("bno", data.bno);
					// 조작용 버튼을 활성화
					replyDiv.find("button[id != 'modalCloseBtn']").hide();
					modalModBtn.show();
					modalRemoveBtn.show();

					replyDiv.show();
				},
				function(er) {
					alert("Error : " + er);
				});
	});
	
	//상세 조회 창 닫기
	modalCloseBtn.on("click", function(e){
		replyDiv.hide();
	});
	
	//댓글 수정 처리
	modalModBtn.on("click", function(e){
		var reply = {
				rno:replyDiv.data("rno"),
				content:modalInputReplyContent.val()
		};
		replyClientService.update(
				reply,
				function(result) {
					replyDiv.hide();
					showReplyList(curPageNum);
				},
				function(er) {
					alert("Error : " + er);
				});
	});

	//댓글 삭제 처리
	modalRemoveBtn.on("click", function(e){
		var rno = replyDiv.data("rno");
		replyClientService.remove(
				rno,
				function(msg) {
					replyDiv.hide();
					showReplyList(curPageNum);
				},
				function(er) {
					alert("Error : " + er);
				});
	});
	
	var operForm = $("#operForm");

	$("button[data-oper='modify']").on("click",
			function(e) {
				operForm.attr("action", "/board/modify");
				operForm.submit();
			});

	$("button[data-oper='list']").on("click", function(e) {
		operForm.find("#bno").remove();
		operForm.attr("action", "/board/list");
		operForm.submit();
	});
	

});
</script>	
	
	
	
	
	
	
	
	
	
	
	