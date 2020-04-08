<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/WEB-INF/views/includes/header.jsp" %> <!-- header jsp 상단에 위치시키는 기능 -->
<!-- [] 표시의 경우 기능개발에 필요한 정보 작성 -->
<!--   Core JS Files   -->
   
<meta charset="utf-8"/>

<title>농구장 찾기 </title>
<link href="../assets/css/map.css" rel="stylesheet" type="text/css">
<!-- 라이브러리 service 추가  -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=ad0e04372c5601e53affb1d55c0dc767&libraries=services,clusterer"></script><!-- &libraries=clusterer --> 
<!-- 지도 & 행정도 주소정보 박스 묶음 -->
<div class="map_wrap">
	<!-- 화면에 위치하는 지도 크기 -->
	<div id="map" style="width:80%;height:500px; position:relative; overflow:hidden; border-radius:10px; border: 5px solid #f5fc03;"></div>
	<!--  행정동 주소정보  박스 표시내용   -->
	<div class="hAddr">
		<span class="title">지도중심기준 행정동 주소정보</span>
		<span id="centerAddr"></span>
	</div>
	<div >
	<button type="button" class="btn-primary btn-simple" onclick="location.href='https://map.kakao.com/?eName=카카오' ">길찾기</button> 
	<!-- Trigger/Open The Modal -->
	<button id="myBtn" class="btn-primary btn-simple">농구장 등록</button>
</div>
</div>

<!-- 위도경도  인포를 나타냄 -->
<div id="clickAddr"></div> 
<!-- 위도경도  인포를 나타냄 -->
<div id="clickLatlng"></div> 
  

  

<!--------------- 모달시작   : form으로 감쌈-------------------------->
<form id = "mapUploardForm" role = "form" action = "insert.do" method = "post">
<!-- The Modal -->
<div class = "modal" id="CourtAddress" >
      
        <!-- Modal content -->
        <div class="Court-info">
           <div>
              <span class="close">&times;</span>  <!-- 닫기(x)버튼 -->
           </div>
           
           <div class = "container" >
           	
			<h5><strong>농구장</strong></h5>
			<div class="form-group" id="divCourtId">
				<!-- 등록자 이름 -->
				<label for="inputCourtId" class="col-lg-2 control-label">등록자 이름</label>   
				<div class="col-lg-7"> 
					<input type="text" class="form-control onlyAlphabetAndNumber" 
					value='<c:out value="${userId}" />' name="user_id" 
					data-rule-required="true" maxlength="12" readonly = "readonly">
				</div>
				<!-- 농구장 이름 -->
				<label for="inputCourtId" class="col-lg-2 control-label">농구장 이름</label>   
				<div class="col-lg-7"> 
					<input type="text" class="form-control onlyAlphabetAndNumber" 
					name="name" data-rule-required="true" 
					placeholder="지역명, 명칭을 활용해 알아보기 쉬운 이름으로 작성해주세요." maxlength="12">
				</div>
			</div>
   			
			<div class="form-group" id="divCourtAdress">
				<!-- 농구장 주소    -->
				<label for="inputCourtAdress" class="col-lg-2 control-label">농구장 주소</label>
				<div class="col-lg-7">
					<input type="text" class="form-control onlyAlphabetAndNumber" 
					id = "address" name="address" data-rule-required="true"  maxlength="12" readonly = "readonly">
				</div>
				<!-- 농구장 위치 위도 -->
				<div  class="col-lg-7">
					<input type="hidden" class="form-control `onlyAlphabetAndNumber" 
					id="latitude" name="latitude" data-rule-required="true"  maxlength="15" readonly = "readonly">
				</div>
				<!--  농구장 위치 경도 -->
				<div  class="col-lg-7">
					<input type="hidden" class="form-control onlyAlphabetAndNumber" 
					id="longitude" name="longitude" data-rule-required="true"  maxlength="15" readonly = "readonly">
				</div>
			</div>

			
			<h5><strong>농구코트 수</strong></h5>                     
			<div class="form-group">
				<!-- 농구코트 수 ( 풀코트 ) -->
				<label for="inputCourtNum" class="col-lg-3 control-label">풀코트</label>
				<div class="col-lg-7" >
					<select class="form-control" name="full_court_num">
						<option value="1">없음</option>
						<option value="2">1개</option>
						<option value="3">2개</option>
						<option value="4">3개</option>
						<option value="5">4개 이상</option>
					</select>
				</div>
				<!-- 농구코트 수 ( 반코트 ) -->
				<label for="inputCourtNum" class="col-lg-2 control-label">반코트</label>
				<div class="col-lg-7" >
					<select class="form-control" name="half_court_num">
						<option value="1">없음</option>
						<option value="2">1개</option>
						<option value="3">2개</option>
						<option value="4">3개</option>
						<option value="5">4개 이상</option>
					</select>
				</div>
			</div>                     

              <!--   농구장 소개    -->
			<h5><strong>농구장 소개</strong></h5>
			<div class="form-group" id="divCourtExplain">
				<div class="col-lg-7">
					<input type="textarea" class="form-control onlyAlphabetAndNumber" 
					name="content" data-rule-required="true"  
					placeholder="농구장에 대한 간단한 소개를 해주세요(실력수준, 농구장 장점, 바닥제질 등등)"  maxlength="200">
				</div>
			</div>
			
			<!--   등록 버튼     -->
			<div class="form-group">
				<div class="col-lg-offset-2 col-lg-10">
					<button data-oper="register" class="btn btn-success">등록</button><!-- 클래스 css에서 갖다쓴건가  -->
				</div>
				<div class="col-lg-7">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><!-- 뭔지몰라서 못건드림 -->
				</div>
			</div>

           </div>
	</div>
</div>
</form>
  <!-- 모달 끝   -->     

<%@include file="/WEB-INF/views/includes/footer.jsp" %>	

<script src="../../assets/js/Event_handler_map.js"></script>  
<script src="../../assets/js/map.js"></script>  

<script type="text/javascript">
	$(document).ready(function() {
		var mapUploardForm = $("#mapUploardForm");
	    $("button").on("click", function(e){
	       e.preventDefault();
	       var oper = $(this).data('oper');
	       if (oper === 'register'){
	          mapUploardForm.submit();
	       }
	    });
   	});
</script>

 