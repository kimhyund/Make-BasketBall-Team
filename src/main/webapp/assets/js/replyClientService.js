console.log("Reply Module...");

var replyClientService = (
		function (){
			function add(reply, callback, error){
				console.log("Add of Reply Module...");
				$.ajax({
					type: 'post',
					url: '/reply/createReply',
					data: JSON.stringify(reply),
					contentType: "application/json;charset=utf-8",
					success: function (result, status, xhr){
						if(callback){
							callback(result);
						}
					},
					error: function(xhr, status, er){
						if (error) {
							error(er);
						}
					}
				});
			}
			function get(rno, callBack, error) {
				$.get(
					//.json의 효과는 json 형태의 결과물로 주세요
					"/reply/getReply/" + rno + ".json",
					function(data) {
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

			function getList(param, callBack, error) {
				var bno = param.bno;
				var page = param.page || 1;
				var pageSize = param.pageSize;
				var restUrl = "/reply/getPagingReply/" + bno + "/" + page +"/" + pageSize + ".json"; 
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

			function remove(bno, rno, callBack, error) {
				$.ajax({
					type : 'delete',
					url : '/reply/deleteReply/'+bno+'/' + rno,
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

			function update(reply, callBack, error) {
				console.log("Add of Reply Module...");
				
				$.ajax({
					type : 'put',
					url : '/reply/updateReply',
					data : JSON.stringify(reply),
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

			function displayTime(timeValue) {
				var today = new Date();
				var gap = today.getTime() - timeValue;
				var dateObj = new Date(timeValue);
				var str = "";
				if (gap < (1000 * 60 * 60 * 24)) {
					//오늘 올라온 글이면
					var hh = dateObj.getHours();
					var mm = dateObj.getMinutes();
					var ss = dateObj.getSeconds();
					return [(hh > 9 ? '' : '0') + hh, ':',
						(mm > 9 ? '' : '0') + mm, ':',
						(ss > 9 ? '' : '0') + ss
						].join('');
				} else {
					var yy = dateObj.getFullYear();
					var mm = dateObj.getMonth() + 1;
					var dd = dateObj.getDate();
					return [yy,'/', (mm>9?'':'0') + mm, '/',
						(dd>9?'':'0') + dd].join('');
				}
			}
			return {
				get:get,
				getList:getList,
				add:add,
				remove:remove,
				update:update,
				displayTime:displayTime};
			
		}
)();