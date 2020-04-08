<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@include file="../includes/header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid">

	<!-- DataTales Example -->
	<div class="card shadow mb-4">
		<div class="card-body">
			<div class="table-responsive">
				<!-- table 상단에 게시글 쓰기 앵커 추가 -->
				<sec:authorize access="isAuthenticated()">
				<button id="regPost" class="btn btn-default">게시글 쓰기</button>
				</sec:authorize>
				<!-- 검색처리 -->
				<form id="searchForm" class="pull-right" action="/board/list" method="get">
					<select name="searchType">
						<option value="" <c:out value="${pageMaker.searchType == null ? 'selected' : '' }" />>--</option>
						<option value="G" <c:out value="${pageMaker.searchType eq 'G' ? 'selected' : '' }" />>타입</option>
						<option value="T" <c:out value="${pageMaker.searchType eq 'T' ? 'selected' : '' }" />>제목</option>
						<option value="C" <c:out value="${pageMaker.searchType eq 'C' ? 'selected' : '' }" />>내용</option>
						<option value="W" <c:out value="${pageMaker.searchType eq 'W' ? 'selected' : '' }" />>작성자</option>
						<option value="TC" <c:out value="${pageMaker.searchType eq 'TC' ? 'selected' : '' }" />>제목|내용</option>
						<option value="TW" <c:out value="${pageMaker.searchType eq 'TW' ? 'selected' : '' }" />>제목|작성자</option>
						<option value="TCW" <c:out value="${pageMaker.searchType eq 'TCW' ? 'selected' : '' }" />>제목|내용|작성자</option>
					</select>
					<input type="text" name="keyword" value='<c:out value="${pageMaker.keyword}" />'>
					<input type="hidden" name='pageNum' value='${pageMaker.pageNum}'>
					<input type="hidden" name='amount' value='${pageMaker.amount}'>
					<button class='btn btn-default'>검색</button>
				</form>
				<!-- End of 검색처리 -->
				<!-- table tag property에 의하여 테이블 상단 메뉴 자동 생성됨 -->
				
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>id</th>
							<th>title</th>
							<th>content</th>
							<th>writer</th>
							<th>regdate</th>
							<th>updatedate</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="board" items="${listAllBoard}">
							<tr>
								<td>${board.bno}</td>
								<td>
									<a class='showDetail' id='${board.type}' href='<c:out value="${board.bno}"/>'>
										[${board.type}]${board.title}[${board.replyCount}]
									</a>
								</td>
								<td>${board.content}</td>
								<td>${board.writer}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.regdate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${board.updatedate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			
				<!-- Pagination -->
				<div class='pull-right'>
					<ul class='pagination'>
						<c:if test="${pageMaker.hasPrev}">
							<li class='paginate_button previous'><a href="${pageMaker.startPage - 1}">Prev</a></li>
						</c:if>
						<c:forEach var="num" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
							<li class="paginate_button ${pageMaker.pageNum == num ? 'active':''}">
								<a href="${num}">${num}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.hasNext}">
							<li class='paginate_button next'><a href="${pageMaker.endPage + 1}">Next</a></li>
						</c:if>
					</ul>
				</div>
				<form id='actionForm' action="/board/list" method="get">
					<input type="hidden" name='pageNum' value='${pageMaker.pageNum}'>
					<input type="hidden" name='amount' value='${pageMaker.amount}'>
					<input type="hidden" name="searchType" value='<c:out value="${pageMaker.searchType}" />'>
					<input type="hidden" name="keyword" value='<c:out value="${pageMaker.keyword}" />'>
				</form>
				
				<!-- End of Pagination -->
				<form id='bForm' method="get">
					<input type="hidden" name="type" value='board'>
				</form>
			</div>
		</div>
	</div>

</div>
<!-- /.container-fluid -->
<!-- Modal 추가 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
	aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"
					aria-hidden="true">&times;</button>
				<h4 class="modal-title" id="myModalLabel">처리확인</h4>
			</div>
			<div class="modal-body">처리가 완료 되었습니다.</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
		<!-- /.modal-content -->
	</div>
	<!-- /.modal-dialog -->
</div>
<!-- /.modal -->
<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {
		var result = '<c:out value="${result}" />';
		
		checkModal(result);
		
		history.replaceState({}, null, null);
		
		function checkModal(result) {
			if (result === '' || history.state) {
				return;
			}
			if (parseInt(result) > 0) {
				$(".modal-body").html("게시글 " + result + "번이 등록되었습니다.");
			} else {
				$(".modal-body").html(result);
			}
			$("#myModal").modal("show");
		}
		
		//regPost id를 가지는 요소에서 클릭이 발생하면 이 함수에서 처리합니다.
		$("#regPost").on("click", function(){
			var bForm = $("#bForm");
			bForm.attr("action", "/board/createPost");
			bForm.submit();
		});

		//검색 폼에서의 작동 처리
		var searchForm = $("#searchForm");
		$('#searchForm button').on('click', function(e){
			if (!searchForm.find("option:selected").val()) {
				alert("검색 종류를 선택하세요!");
				return;
			}

			if (!searchForm.find("input[name='keyword']").val()) {
				alert("키워드를 입력하세요!");
				return;
			}

			//첫 검색 시는 첫 페이지를 보여주어야합니다.
			searchForm.find("input[name='pageNum']").val(1);
			
			e.preventDefault();
			searchForm.submit();
		});
		//paginate_button에서 클릭 이벤트로 해당 페이지 띄우기
		var actionForm = $("#actionForm");
		$('.paginate_button a').on('click', function(e){
			e.preventDefault();
			//클릭한 앵커의 href값을 form안의 pageNum input에 기록한다.
			var pn = $(this).attr("href");
			var inPageNum = actionForm.find("input[name='pageNum']");
			inPageNum.val(pn);
			var modified = inPageNum.val();
			//actionForm.find("input[name='pageNum']").val($(this).attr("href"));
			actionForm.submit();
		});

		//상세 보기 시 몇 쪽에서 일어난 일인지 넘겨줘서 복귀 시 이곳으로 돌아오기
		$(".showDetail").on('click', function(e){
			e.preventDefault();
			actionForm.append("<input type='hidden' name='bno' value='" 
					+ $(this).attr("href") + "'>");
			actionForm.append("<input type='hidden' name='type' value='" 
					+ $(this).attr("id") + "'>");
			if ($(this).attr("id") == "board"){
				actionForm.attr("action", "/board/showDetail");
			} else{
				actionForm.attr("action", "/board/showDetail_G");
			}
			actionForm.submit();
		});
	});
</script>







