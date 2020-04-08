<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@include file="../includes/header.jsp" %>

  <link href="../assets/css/teamRegistry.css" rel="stylesheet" type="text/css">
  <sec:authentication property="principal" var="customUser"/>
<div class="row" style="background: #ffffff; padding: 25px; border-radius: 10px;">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">팀 관리</div>
			<div class="panel-body">
				<div class="form-group">
					<label>team name : </label>
					<input class="form-control" type="text" name="bno" 
					value='<c:out value="${team.teamName}" />' readonly="readonly">
				</div>
				<div class="form-group">
					<label>team member : </label>
					<input class="form-control" type="text" name="title" 
					value='<c:out value="${memberList}" />' readonly="readonly">
				</div>
				<div class="form-group">
					<label>description : </label>
					<input class="form-control" type="text" name="description" 
					value='<c:out value="${team.description}" />' readonly="readonly">
				</div>
				<sec:authorize access="isAnonymous()">
				<div class="col-md-12">
					<div class="card card-plain">
						<button class="btn-success btn-simple" onclick="location.href='/customLogin'">로그인을 해주세요</button>
					</div>
				</div>
				
				</sec:authorize>
				
				<sec:authorize access="isAuthenticated()">
					<c:if test="${customUser.member.id eq team.leader}">
						<button data-oper='modify' class="btn btn-default">수정</button>
						<div class="col-lg-7">
							<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
						</div>
					</c:if>
					<c:if test="${customUser.member.id ne team.leader}">
							<button data-oper='chat' class="btn btn-info">대화</button>
							<button data-oper='t_register' class="btn btn-info" id ="t_register">가입신청</button>
					</c:if>
				
						<!-- 모달시작   -->
				   <form id = "registerForm" role = "form" action = "join.do" method = "post">
				   <!-- The Modal -->
				      <div class = "modal" id="TeamRegistry" >
				       
				         <!-- Modal content -->
				         <div class="Court-info">
				            <div>
				               <span class="close">&times;</span>  <!-- 닫기(x)버튼 -->
				            </div>
				            <div class = "container" >
				                <h5><strong>가입신청</strong></h5>
				                <div class="form-group" id="divCourtId">
				                   <label for="inputCourtId" class="col-lg-2 control-label">신청자 이름</label>   
				                  <div class="col-lg-7"> 
				                     <input type="text" class="form-control" 
				                     value='<c:out value="${customUser.member.id}" />' id ="user_id" name="user_id" 
				                     data-rule-required="true" maxlength="12" readonly = "readonly">
				                  </div>
				                </div>
				               <!--   본인소개    -->
				               <h5><strong>본인 소개</strong></h5>
				               <div class="form-group" id="divCourtExplain">
				                  <div class="col-lg-7">
				                     <input type="textarea" class="form-control onlyAlphabetAndNumber" 
				                     name="content" data-rule-required="true"  
				                     placeholder="본인에 대한 간단한 소개를 해주세요(실력수준, 장점, 포지션 등등)"  maxlength="200">
				                  </div>
				               </div>
				               <div class="form-group" id="divCourtExplain">
				               	<div class="col-lg-7">
				                     <input type="text" id="teamLeaderId" name="teamLeaderId"  value = "${team.leader}">
				                 </div>    
				               </div>
				               <div class="form-group" id="divCourtExplain">
				               	<div class="col-lg-7">
				                     <input type="text" id="team_id" name="team_id"  value = "${team.teamName}">
				                 </div>    
				               </div>
				               
				               <!--   등록 버튼     -->
				               <div class="form-group">
				                  <div class="col-lg-offset-2 col-lg-10">
				                     <button data-oper="register" class="btn btn-success" id="submit" disabled = "disabled">등록</button><!-- 클래스 css에서 갖다쓴건가  -->
				                     <button type="button"  id="rCheck" class="btn btn-success">요청 중복 확인</button>
				                  </div>
				                  <p class="result">
				                  	<span class="msg">중복확인</span>
				                  </p>
				                  <div class="col-lg-7">
				                     <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><!-- 뭔지몰라서 못건드림 -->
				                  </div>
				               </div>
				            </div>   
				         </div>
				       </div>
				    </form>
				    </sec:authorize>
				
				   <!-- 모달 끝   -->  
				<form id='teamForm' action="/team/list" method="get">
					<input type="hidden" id="teamName" name="teamName" value='<c:out value="${team.teamName}" />'>
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
$(document).ready(function(){
	
	var teamForm = $("#teamForm");
	var registerForm = $("#registerForm");
	$("button[data-oper='modify']").on("click", function(e){
		teamForm.attr("action", "/team/modify");
		teamForm.submit();
	});

	$("button[data-oper='list']").on("click", function(e){
		teamForm.find("#bno").remove();
		teamForm.attr("action", "/team/list");
		teamForm.submit();
	});
	$("button[data-oper='register']").on("click", function(e){
		registerForm.submit();	
	});
	$("#rCheck").click(function(){
		
		var info = {
			user_id : $("#user_id").val(),
			team_id : $("#team_id").val()
		};
		$.ajax({
			type : 'post',
			data : JSON.stringify(info),
			url : '/team/requestCheck/',
			contentType : "application/json;charset=utf-8",
			success : function(datas, status, xhr) {
				if(datas == 1){
					$(".result .msg").text("request exist");
				} else{
					$(".result .msg").text("applicable");
					$("#submit").removeAttr("disabled");
				}
				console.log(datas);
				console.log(status);
				console.log(xhr);
			},
			
		});
	});
});
</script>	
	
	
	
	
	
	
	
	
	
	
	