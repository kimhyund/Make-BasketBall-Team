<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

<title>회원 탈퇴</title>
<form id="signoffForm" role="form" action="deleteMember" method="post">
<div class="container" style="background: #ffffff; padding: 40px; border-radius: 10px;">
    <h4><strong>회원 탈퇴</strong></h4>
    <div class="form-group" id="divName">
		<label class="col-lg-10 control-label">정말로 탈퇴 하시겠습니까?</label>
		<label class="col-lg-10 control-label">회원 탈퇴 사유를 작성해주세요.</label>
	</div>
	<div class="form-group" id="divName">
		<label for="inputName" class="col-lg-2 control-label">탈퇴 사유</label>
		<div class="col-lg-7">
			<textarea class="form-control onlyHangul" name="reason" rows="10" cols="50" placeholder="회원 탈퇴 사유를 기재해주세요.">
			</textarea>
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-offset-2 col-lg-10">
			<button data-oper="delete" type="submit" class="btn btn-success">탈퇴</button>
			<button data-oper="reset" type="reset" class="btn btn-info">초기화</button>
		</div>
		<div class="col-lg-7">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</div>
	</div>
</div>
</form>

<%@include file="../includes/footer.jsp" %>

<script type="text/javascript">
$(document).ready(function() {
	
	$(".onlyHangul").keyup(function(event){
		if (!(event.keyCode >=37 && event.keyCode<=40)) {
			var inputVal = $(this).val();
			$(this).val(inputVal.replace(/[a-z0-9]/gi,''));
		}
	});
    
	$("button").on("click", function(e) {
		e.preventDefault();
		var signoffForm = $("#signoffForm");
		var oper = $(this).data("oper");
		
		if (oper === "delete") {
			signoffForm.submit();
		}
	});

});
</script>
