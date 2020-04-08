<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>
    
<title>profile 등록/수정</title>
<form id="profileForm" role="form" action="updateProfile" method="post">

<div class="container" style="background: #ffffff; padding: 40px; border-radius: 10px;">
    <h4><strong> profile edit</strong></h4>
	<div class="form-group" id="divHeight">
		<label for="inputHeight" class="col-lg-2 control-label">신장</label>
		<div class="col-lg-7">
			<input type="text" class="form-control onlyNumber" name="height" 
				data-rule-required="true" placeholder="키(cm)를 입력하세요" maxlength="3">
		</div>
	</div>
	<div class="form-group" id="divAddress">
		<label for="inputAddress" class="col-lg-2 control-label">주소</label>
		<div class="col-lg-7">
			<input type="text" class="form-control onlyHangul" name="address" 
				data-rule-required="true" placeholder="주소를 시/군(구)/동 단위로 입력하세요." 
				maxlength="50">
		</div>
	</div>
	<div class="form-group" id="divNickname">
		<label for="inputNickname" class="col-lg-2 control-label">닉네임</label>
		<div class="col-lg-7">
			<input type="text" class="form-control" name="nickName" 
				data-rule-required="true" placeholder="애용하는 닉네임을 입력하세요." 
				maxlength="50">
		</div>
	</div>
	<div class="form-group">
		<label for="inputPosition" class="col-lg-2 control-label">포지션</label>
		<div class="col-lg-7">
			<select class="form-control" name="position">
				<option value="1">Point Guard</option>
				<option value="2">Shooting Guard</option>
				<option value="3">Small Forward</option>
				<option value="4">Power Forward</option>
				<option value="5">Center</option>
			</select>
		</div>
	</div>
	<div class="form-group">
		<label for="inputGender" class="col-lg-2 control-label">성별</label>
		<div class="col-lg-7">
			<select class="form-control" name="gender">
				<option value="1">남자</option>
				<option value="2">여자</option>
			</select>
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-offset-2 col-lg-10">
		
			<button type="submit" data-oper="register" class="btn btn-success">프로필 수정</button>
			<button type="reset" data-oper="reset" class="btn btn-success">초기화</button>
			
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

		$(".onlyAlphabetAndNumber").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val($(this).val().replace(/[^_a-z0-9]/gi,'')); //_(underscore), 영어, 숫자만 가능
			}
		});
         
		$(".onlyHangul").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[a-z0-9]/gi,''));
			}
		});
     
		$(".onlyNumber").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^0-9]/gi,''));
			}
		});
		
		
		$("button").on("click", function(e) {
			e.preventDefault();
			
			var profileForm = $("#profileForm");
			var oper = $(this).data("oper");
						
			if (oper === "register") {
				profileForm.submit();	
			}
		});

	});
</script>
