b <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<%@include file="../includes/header.jsp"%>
<!-- Begin Page Content -->
<div class="container-fluid">
	<!-- DataTales Example -->
	<div class="card shadow mb-4">`
		<div class="card-body">
			<div class="table-responsive">
				<button id="regTeam" class="btn btn-default">팀생성</button>
				<!-- table tag property에 의하여 테이블 상단 메뉴 자동 생성됨 -->
				<table class="table table-bordered" id="dataTable" width="100%"
					cellspacing="0">
					<thead>
						<tr>
							<th>Team Name</th>
							<th>Description</th>
							<th>regdate</th>
							<th>updatedate</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="team" items="${listAllTeams}">
							<tr>
								<td>
									<a class='teamDetail' href='<c:out value="${team.teamName}"/>'>
										${team.teamName}[${team.num_member}]
									</a>
								</td>
								<td>${team.description}</td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${team.regdate}" /></td>
								<td><fmt:formatDate pattern="yyyy-MM-dd"
										value="${team.updatedate}" /></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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
			<form id='randomForm' action="/team/list" method="get">
					<input type="hidden" name='pageNum' value='${pageMaker.pageNum}'>
					<input type="hidden" name='amount' value='${pageMaker.amount}'>
					<input type="hidden" name="searchType" value='<c:out value="${pageMaker.searchType}" />'>
					<input type="hidden" name="keyword" value='<c:out value="${pageMaker.keyword}" />'>
				</form>
				
				
			</div>
		</div>
	</div>

</div>
<!-- /.container-fluid -->

<%@include file="../includes/footer.jsp"%>

<script type="text/javascript">
	$(document).ready(function() {

		
		var randomForm = $("#randomForm");
		$("#regTeam").on("click", function(){
			self.location = "/call/team/createTeam";
		});

		//상세 보기 시 몇 쪽에서 일어난 일인지 넘겨줘서 복귀 시 이곳으로 돌아오기
		$(".teamDetail").on('click', function(e){
			e.preventDefault();
			randomForm.append("<input type='hidden' name='teamName' value='" 
					+ $(this).attr("href") + "'>");
			randomForm.attr("action", "/team/teamManage");
			randomForm.submit();
		});
		
		$('.paginate_button a').on('click', function(e){
			e.preventDefault();
			//클릭한 앵커의 href값을 form안의 pageNum input에 기록한다.
			var pn = $(this).attr("href");
			var inPageNum = randomForm.find("input[name='pageNum']");
			inPageNum.val(pn);
			var modified = inPageNum.val();
			randomForm.submit();
		});
	});
</script>







