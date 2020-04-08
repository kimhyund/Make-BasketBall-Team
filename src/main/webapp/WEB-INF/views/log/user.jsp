	<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@include file="/WEB-INF/views/includes/header.jsp" %>
<link href="../assets/css/teamRegistry.css" rel="stylesheet" type="text/css">
        <div class="row">
          <div class="col-md-4">
             <div class="card">
              <div class="card-header">
                <h4 class="card-title">Team Lists</h4>
              </div>
              <div class="card-body">
                <ul class="team-members">
                     <c:forEach var="user" items="${teamLists}">
                     <li>
                     <table>
                     <tbody>
	                     <tr>
	                     <th>
	                     	<a class='showTeamDetail' href='/team/teamManage?teamName=${user.team_id}'>
	                              ${user.team_id}
	                           </a>
	                      	<br>
	                      	</th>
	                      </tr>
                     </tbody>
                     
                     </table>
                       	
                  	</li>
                  	</c:forEach>
                  
                </ul>
              </div>
            </div>
            <!-- request Lists -->
              <div class="card">
              <div class="card-header">
                <h4 class="card-title">request Lists</h4>
              </div>
              <div id="requestDiv" class="card-body">
                <ul id="requestContainer">
                  
                </ul>
              </div>
            </div>
          </div>
          <!-- profile -->
          <div class="col-md-8">
            <div class="card card-user">
              <div class="card-header">
                <h5 class="card-title">Edit Profile</h5>
              </div>
              <div class="card-body">
                <form id="profileUpdateForm" action="/member/profile" method="get">
                  
                  <div class="row">
                    <div class="col-md-4 pr-10">
                      <div class="form-group">
                        <label>유저 아이디 </label>
                        <input type="text" class="form-control" disabled=""  value='<c:out value="${userId}" />'>
                      </div>
                    </div>
                    <div class="col-md-4 px-1">
                      <div class="form-group">
                        <label>닉네임 </label>
                        <input type="text" class="form-control" disabled= ""  placeholder="Empty Nickname" value='<c:out value="${userNickName}" />'>
                      </div>
                    </div>
                  </div>
                  
                  <div class="row">
                    <div class="col-md-3 pr-1">
                      <div class="form-group">
                        <label for="exampleInputEmail1">성별</label>
                        <input type="text" class="form-control" disabled= "" placeholder="Empty" value='<c:out value="${userGender}" />'>
                      </div>
                    </div>
                    <div class="col-md-5 pr-1">
                      <div class="form-group">
                        <label>Position</label>
                        <input type="text" class="form-control" placeholder="Empty Position" value='<c:out value="${userPosition}" />'>
                      </div>
                    </div>
                    <div class="col-md-4 pl-1">
                      <div class="form-group">
                        <label> 키 </label>
                        <input type="text" class="form-control" placeholder="Empty Height" value='<c:out value="${userHeight}" />cm'>
                      </div>
                    </div>
                  </div>

				  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label>Email address</label>
                        <input type="email" class="form-control"  value='<c:out value="${userEmail}" />'>
                      </div>
                    </div>
                  </div>
                 
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label>Address</label>
                        <input type="text" class="form-control" placeholder="Empty Address" value='<c:out value="${userAddress}" />'>
                      </div>
                    </div>
                  </div>
                  
                  <div class="row">
                    <div class="col-md-12">
                      <div class="form-group">
                        <label>About Me</label>
                        <textarea class="form-control textarea">Oh so, your weak rhyme You doubt I'll bother, reading into it</textarea>
                      </div>
                    </div>
                  </div>
                  <div class="row">
                    <div class="update ml-auto mr-auto">
                      <button type="submit" class="btn btn-primary btn-round">Update Profile</button>
                    </div>
                  </div>
                </form>
              </div>
            </div>
          </div>
        </div>
<form id = "requestForm" role = "form">
<!-- The Modal -->
<div class = "modal" id="reqModal" >
        <!-- Modal content -->
        <div class="Court-info">
           <div>
              <span class="close">&times;</span>  <!-- 닫기(x)버튼 -->
           </div>
           
           <div class = "container" >
           	
			<h5><strong>신청인</strong></h5>
			<div class="form-group" id="divCourtId">
				<!-- 등록자 이름 -->
				<label for="inputCourtId" class="col-lg-2 control-label">신청자 이름</label>   
				<div class="col-lg-7"> 
					<input type="text" class="form-control onlyAlphabetAndNumber" 
					 name="user_id" 
					id="request_uid" maxlength="12" readonly = "readonly">
				</div>
				<!-- 농구장 이름 -->
				<label for="inputCourtId" class="col-lg-2 control-label">팀 이름</label>   
				<div class="col-lg-7"> 
					<input type="text" class="form-control onlyAlphabetAndNumber" 
					name="name" id="request_tid"
					maxlength="12">
				</div>
			</div>
              <!--   농구장 소개    -->
			<h5><strong>본인 소개</strong></h5>
			<div class="form-group" id="divCourtExplain">
				<div class="col-lg-7">
					<input type="text" class="form-control onlyAlphabetAndNumber" 
					name="position" id="request_position">
				</div>
			</div>
			
			<!--   등록 버튼     -->
			<div class="form-group">
				<div class="col-lg-7">
					<input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"><!-- 뭔지몰라서 못건드림 -->
				</div>
			</div>
           </div>
	</div>
</div>
</form>
  <!-- 모달 끝   -->     
<%@include file="../includes/footer.jsp" %>

<script type="text/javascript" src="/assets/js/requestService.js">

</script>
<script type="text/javascript">
	$(document).ready(function(){
		var requestDiv = $("#requestDiv");
		var requestuid = $("#request_uid");
		var requesttid = $("#request_tid");
		var requestposition = $("#request_position");
		
		var userId =  '<c:out value="${userId}" />';
		
		var ul4List = $("#requestContainer");
		function showRequestList(){
			requestService.getList(
					userId
					,function (requestList){
				var list = requestList;
				var liHtml = "";
				for(var i = 0, len = list.length || 0; i < len; i++) {
						liHtml += "<li>"
						liHtml += "<tr><td><a class='showRequestDetail' data-rid='"+list[i].rid +"' data-tid='"+list[i].rTid
						liHtml += "' data-pid='"+list[i].position+"'>"
						liHtml +=  list[i].rid
						liHtml +=  "</a></td><td class='col-md-3 col-3 text-right'>" 
						liHtml += 	"<button id='approve' data-id = "+ list[i].rid + " data-tid ="+list[i].rTid + " class='btn btn-sm btn-outline-success btn-round btn-icon'><i class='fa'>y</i></button>"	
						liHtml +=  	"<button id='reject' data-id = "+ list[i].rid +" data-tid ="+list[i].rTid +" class='btn btn-sm btn-outline-success btn-round btn-icon'><i class='fa'>n</i></button>"
						liHtml += "</td></tr><br></li>"	
				}
				ul4List.html(liHtml);
				
			}, function(er){
				alert("error" + er);
			});
		}
		showRequestList();
		
		$("#requestContainer").on("click","li a", function(e){
	          var h= this;
	          var k = $(this).data("tid");
	          var i = $(this).data("rid");
	          var o = $(this).data("pid");
	          requestuid.val(i);
	          requesttid.val(k);
	          requestposition.val(o);
	          modal.style.display = "block";
		});
		
		$("#requestContainer").on("click","li button", function(e) {
			e.preventDefault();
			var buttonId = this.id;
			var rid = $(this).data("id");
			var rTid = $(this).data("tid");
			if (buttonId == "approve"){
				requestService.approved(
						rid,rTid,
					function(msg){
						alert("success");
						showRequestList();
					},function(er) {
						alert("Error : " + er);
					}
				);
			} else {
				requestService.rejected(
						rid,rTid,
						function(msg){
							alert("success");
							showRequestList();
						},function(er) {
							alert("Error : " + er);
						}	
				);
			}
			
			
			
		});
		
	})
</script>
