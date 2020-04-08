<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@include file="../includes/header.jsp" %>

<title>회원등록</title>
<form id="registerForm" role="form" action="/member/insert.do" method="post">

<div class="container" style="background: #ffffff; padding: 40px; border-radius: 10px;">
    <h4><strong>회원등록</strong></h4>
    <div class="form-group" id="divId">
    	<label for="inputId" class="col-lg-2 control-label">아이디</label>
		<div class="col-lg-7">
			<input type="text" class="form-control onlyAlphabetAndNumber" name="id" 
				id="id" data-rule-required="true" 
				placeholder="12자이내의 알파벳, 언더스코어(_), 숫자만 입력 가능합니다." maxlength="12">
		</div>
    </div>
    <div class="form-group" id="divPassword">
		<label for="inputPassword" class="col-lg-2 control-label">패스워드</label>
		<div class="col-lg-7">
			<input type="password" class="form-control NoHangul" 
				name="password" id="password" data-rule-required="true" 
				placeholder="패스워드. '숫자와 영문자 특수문자'를 조합하여 8~12자리 입력 가능합니다." maxlength="12">
		</div>
	</div>
	<div class="form-group" id="divPasswordCheck">
		<label for="inputPasswordCheck" class="col-lg-2 control-label">패스워드 확인</label>
		<div class="col-lg-7">
			<input type="password" class="form-control NoHangul" 
				 id="passwordCheck" 
				data-rule-required="true" placeholder="패스워드 확인" maxlength="12">
		</div>
	</div>
		<div class="form-group" id="divName">
		<label for="inputName" class="col-lg-2 control-label">이름</label>
		<div class="col-lg-7">
			<input type="text" class="form-control onlyHangul" name="name" 
				data-rule-required="true" placeholder="이름을 입력하세요" maxlength="50">
		</div>
	</div>
		<div class="form-group" id="divPhone">
		<label for="inputPhone" class="col-lg-2 control-label">전화번호</label>
		<div class="col-lg-7">
			<input type="text" class="form-control onlyNumber" name="phone" 
				data-rule-required="true" placeholder="전화번호를 숫자만 입력하세요." maxlength="11">
		</div>
	</div>
	<div class="form-group" id="divEmail">
		<label for="inputEmail" class="col-lg-2 control-label">이메일</label>
		<div class="col-lg-7">
			<input type="text" class="form-control NoHangul" name="email" id="email"
				data-rule-required="true" placeholder="이메일 주소를 입력하세요." maxlength="50">
		</div>
	</div>
	<div class="form-group">
		<div class="col-lg-offset-2 col-lg-10">
			<button data-oper="register" type="submit" class="btn btn-success">등록</button>
			<button data-oper="reset" type="reset" class="btn btn-success">초기화</button>
		</div>
		<div class="col-lg-7">
			<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}">
		</div>
	</div>
	
</div>
</form>

<%@include file="../includes/footer.jsp" %>
<!-- <script type="text/javascript" src="/resources/js/member.js"></script> -->

<script type="text/javascript">
	$(document).ready(function() {
		//Security 적용 이후 Ajax의 post에서 정상 작동을 위해 csrf 추가해 줌
		var csrfHeaderName = "${_csrf.headerName}";
		var csrfTokenValue = "${_csrf.token}";
		
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
			
			$(".NoHangul").keyup(function(event){
				if (!(event.keyCode >=37 && event.keyCode<=40)) {
					var inputVal = $(this).val();
					$(this).val(inputVal.replace(/[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/gi,''));
				}
			});
			
			$("#id").focusout(function(e) {
				var inputVal = $(this).val();
				$(this).css("background", "white");
				
				if (!inputVal) {
					alert("아이디를 입력해 주세요.");
					setTimeout(function() {
						$("#id").focus().css("background", "yellow");
					}, 1)
					return;
				} else {
					// 아이디 중복 체크
					$.ajax({
						url:'/member/checkUserId',
						data:{id:inputVal},
						type:'GET',
						dataType:'json',
						success:function(result) {
							if (result) {
								alert("이미 등록되어 있는 아이디입니다. 새로운 아이디를 입력해주세요.");
								setTimeout(function() {
									$("#id").val('').focus().css("background", "yellow");
								}, 1)
								return;
							}
						}
					});
				}
			});
			
			$("#password").blur(function(e) {
				$(this).css("background", "white");
			});
			
			$("#passwordCheck").blur(function(e) {
				var id = $("#id").val();			
				var pwd = $("#password").val();
				var pwdCheck = $(this).val();
				$(this).css("background", "white");
				
				if (!pwd) {
					alert("패스워드를 입력해주세요.");
					setTimeout(function() {
						$("#password").focus().css("background", "yellow");
					}, 1)
					return;
				} else if (!pwdCheck || pwd != pwdCheck) {
					alert("패스워드가 다릅니다. 다시 입력해주세요.");
					setTimeout(function() {
						$("#passwordCheck").val('').focus().css("background", "yellow");
					}, 1)
					return;
				}
				
				checkPassword(id, pwd);
			});
			
			function checkPassword(id, password){
				var regExpPwd = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,12}$/;
				if(!regExpPwd.test(password)) {
					alert('숫자와 영문자 특수문자를 조합하여 8~12자리를 사용해야 합니다.');
					setTimeout(function() {
						$("#password").val('').focus().css("background", "yellow");
					}, 1)
					return false;
				}
	
				if(/(\w)\1\1/.test(password)) {
					alert('같은 문자를 3번 이상 사용하실 수 없습니다.');
					setTimeout(function() {
						$("#password").val('').focus().css("background", "yellow");
					}, 1)
					return false;
				}
	
				if(password.search(id) > -1) {
					alert("비밀번호에 아이디가 포함되었습니다.");
					setTimeout(function() {
						$("#password").val('').focus().css("background", "yellow");
					}, 1)
					return false;
				}
				
				if(password.search(/\s/) > -1) {
					alert("비밀번호에 공백이 포함되었습니다.");
					setTimeout(function() {
						$("#password").val('').focus().css("background", "yellow");
					}, 1)
					return false;
				}
				return true;
			}
			
			$("#email").blur(function(e) {
				var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
				var newEmail = $(this).val();
				$(this).css("background", "white");
				
				if (!newEmail) {
					alert("이메일을 입력해주세요.");
					setTimeout(function() {
						$("#email").focus().css("background", "yellow");
					}, 1)
					return;
				} else if (!regExp.test(newEmail)) {
					alert("입력한 이메일 패턴이 정확하지 않습니다. 확인 후 다시 입력해주세요.");
					setTimeout(function() {
						$("#email").val('').focus().css("background", "yellow");
					}, 1)
					return;
				}
			});
			
			
			$("button").on("click", function(e){
				e.preventDefault();
				var registerForm = $("#registerForm");
				var oper = $(this).data("oper");
				if ( oper === "register"){
					alert("가입성공");
					registerForm.submit();
				}
				else {
					
				}
				
				
			});
	
		});
</script>
