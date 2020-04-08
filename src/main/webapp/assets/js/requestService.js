console.log("Reply Module...");

var requestService = (
		function (){

			function getList(userId, callBack, error) {
				var restUrl = "/member/getRequest/" + userId + ".json"; 
				$.getJSON(restUrl, function(data) {
						if (callBack) {
							callBack(data);
						}
					}
				).fail(
					function(xhr, status, er) {
						if (error) {
							error(er);
						}
					}
				);
			}

			function rejected(user_id, team_id, callBack, error) {
				$.ajax({
					type : 'delete',
					url : '/member/rqRejected/' + user_id + '/' + team_id,
					success : function(result, status, xhr) {
						if (callBack) {
							callBack(result);
						}
					},
					error : function (xhr, status, er) {
						if (error) {
							error(er);
						}
					}
				});
			}

			function approved(user_id,team_id, callBack, error) {
				console.log("Add of Reply Module...");
				$.ajax({
					type : 'get',
					url : '/member/rqApproved/' + user_id + '/' + team_id,
					contentType : "application/json;charset=utf-8",
					success : function(result, status, xhr) {
						if (callBack) {
							callBack(result);
						}
					},
					error : function (xhr, status, er) {
						if (error) {
							error(er);
						}
					}
				});
			}
			return {
				getList:getList,
				rejected:rejected,
				approved:approved};
			
		}
)();


var modal = document.getElementById('reqModal');

// Get the <span> element that closes the modal
var span = document.getElementsByClassName("close")[0];  
// 스팬(x)를 누를 경우 모달창 종료
span.onclick = function() { 
	
    modal.style.display = "none";
}

// 모달 창 바깥부분을 클릭 할 경우 모달창 종료
window.onclick = function(event) {
    if (event.target == modal) {
        modal.style.display = "none";
    }
}