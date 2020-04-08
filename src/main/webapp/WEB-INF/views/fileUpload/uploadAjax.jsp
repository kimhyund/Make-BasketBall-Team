<%@ page language="java"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>첨부파일 올리기</title>
	<style>
		#uploadResult{
			width:100%;
			background-color:gray;
		}
		#uploadResult ul{
			display:flex;
			flex-flow:row;
			justify-content:center;
			align-items:center;
		}
		#uploadResult ul li{
			list-style:none;
			padding:10px;
		}
		#uploadResult ul li img{
			width:20px;
		}
		#uploadResult ul li span{
			color:white;
		}
		.bigPicWrapper {
			position: absolute;
			display: none;
			justify-content: center;
			align-items: center;
			top:0%;
			width: 100%;
			height: 100%;
			background-color: gray;
			z-index: 100;
			background: rgba(255, 255, 255, 0.5);
		}
		.bigPic {
			position: relative;
			display: flex;
			justify-content: center;
			align-items: center;
		}
		.bigPic img {
			width: 600px;
		}
	</style>
</head>
<body>
	<h4>파일첨부</h4>
	<div class='uploadDiv'>
		<input type='file' name='uploadFile' multiple>
	</div>
	<button id='btnUpload' class="btn-primary btn-simple">Upload</button>
	
	<div id='uploadResult'>
		<ul>
		</ul>
	</div>
	
	<div class="bigPicWrapper">
		<div class="bigPic">
		</div>
	</div>
</body>
</html>

<script src="https://code.jquery.com/jquery-latest.min.js" 
	integrity="sha384-UM1JrZIpBwVf5jj9dTKVvGiiZPZTLVoq4sfdvIe9SBumsvCuv6AHDNtEiIb5h1kU"
	crossorigin="anonymous"></script>

<script>
var operationMode;
function setOperationMode(caller) {
	//create, modify, showDetail
	operationMode = caller;
	if (caller) {
		if (caller == "showDetail") {
			//첨부 파일 추가 기능 막기. 이유는 ReadOnly 상태로 상세 조회 화면 띄우기 때문
			$("input[type='file']").hide();
		}
	}
}
//게시글 첨부정보를 listattach에 담아서 boardvo에 첨부
function gatherRemainingAttaches(masterName) {
	var strRemainingAttaches = "";
	$("#uploadResult ul li").each(function(idx, obj){
		var liObj = $(obj);
		//data-path data-uuid data-fileName data-type
		strRemainingAttaches += "<input type='hidden' name='listAttach[" + idx + "].fileName' value='" + liObj.data("filename")+ "'>";
		strRemainingAttaches += "<input type='hidden' name='listAttach[" + idx + "].uuid' value='" + liObj.data("uuid")+ "'>";
		strRemainingAttaches += "<input type='hidden' name='listAttach[" + idx + "].uploadPath' value='" + liObj.data("path")+ "'>";
		strRemainingAttaches += "<input type='hidden' name='listAttach[" + idx + "].fileType' value='" + liObj.data("type")+ "'>";
		strRemainingAttaches += "<input type='hidden' name='listAttach[" + idx + "].masterName' value='" + masterName + "'>";
		console.log("11" + strRemainingAttaches );
	});
	return strRemainingAttaches;
}
var uploadResultUl = $("#uploadResult ul");
function showUploadedFile(uploadResultArr) {
	var liHtmls = "";
	
	$(uploadResultArr).each(function(i, obj){
		//URI를 만들어 주세요
		var fileCallPath = encodeURIComponent(obj.showBackFileName);
		if (obj.image) {
			var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;
			//g : 문자열 내의 모든 패턴을 검색한다.
			originPath = originPath.replace(new RegExp(/\\/g), "/");
			
			liHtmls += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "' data-mastername='" + obj.masterName + "' data-masterid='" + obj.masterId +"'><div>";
			liHtmls += "    <a href=\"javascript:showImage(\'" + originPath + "\')\">";
			liHtmls += "        <img src='display?fileName=" + fileCallPath + "'>";
			liHtmls += "    </a>";
			liHtmls += "    <span data-file=\'" + originPath + "\' data-type=\'image\'>";
			liHtmls += "    x</span>";
			if (operationMode == "create" || operationMode == "modify") {
				liHtmls += "    <button data-file=\'" + originPath + "\' data-type=\'image\' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			}
			liHtmls += "</div></li>";
			
		} else {
			var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

			liHtmls += "<li data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "' data-type='" + obj.fileType + "' data-mastername='" + obj.masterName +"' data-masterid='" + obj.masterId +"'><div>";
			liHtmls += "    <a href='/fileUpload/download?fileName=" + fileCallPath + "'>";
			liHtmls += "        <image src='/assets/img/attachFileIcon.png'>";
			liHtmls += "            ";
			liHtmls += "    </a>";
			liHtmls += "    <span>"+obj.fileName+" </span>";
			//첨부 취소
				liHtmls += "    <button data-file=\'" + fileLink + "\' data-type=\'file\' type='button' class='btn btn-warning btn-circle'><i class='fa fa-times'></i></button><br>";
			liHtmls += "</div></li>";
		}
	});
	uploadResultUl.append(liHtmls);
}

$(document).ready(function() {
	//$:입력의 끝 부분
	//*: 0회 이상 연속으로 반복
	//? :  0 또는 1
	var forbiddenFileExts = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var MAX_FILE_SIZE = 5242880;	//5MB
	
	var htmlLoadStatus = $(".uploadDiv").clone();
	
	
	function checkExt(fileName, fileSize) {
		if (fileSize > MAX_FILE_SIZE) {
			alert("업로드 대상 파일 " + fileName +" 크기는 5MB를 초과 할 수 없습니다.");
			return false;
		}
		
		if (forbiddenFileExts.test(fileName)) {
			alert(fileName +"은 업로드 할 수 없습니다.");
			return false;
		}
		return true;
	}
	
	$("#btnUpload").on("click", function(e) {
		var formData = new FormData();
		var fileInput = $("input[type='file']");
		var selectedFiles = fileInput[0].files;
		
		console.log(selectedFiles);
		
		for (var i = 0; i < selectedFiles.length; i++) {
			
			if (!checkExt(selectedFiles[i].name, selectedFiles[i].size)) {
				return false;
			}
			console.log(selectedFiles[i]);
			formData.append("uploadFile", selectedFiles[i]);
			
		}
		console.log(formData.get('uploadFile'));
		$.ajax({
			url:'/fileUpload/uploadAjaxAction',
			processData:false,
			contentType:false,
			data:formData,
			type:'post',
			dataType:'json',
			success:function(result) {
				alert("Uploaded!");
				$(".uploadDiv").html(htmlLoadStatus.html());
				showUploadedFile(result);
			},
			error:function(status,er) {
				alert("error!"+ er + "status"+ status);
			}
		});
	});
	
	
	
	//삭제하기 Event Delegation
	$("#uploadResult").on("click", "button", function(e){
		var targetFile = $(this).data("file");
		var fileType = $(this).data("type");
		var isImage = fileType == 'image';
		var li = $(this).closest("li");
		var uuid = $(li).data("uuid");
		var mastername = $(li).data("mastername");
		var masterid = $(li).data("masterid");
		$.ajax({
			url:'/fileUpload/deleteFile',
			data:{
				fileName:targetFile, 
				fileType:isImage, 
				masterName:mastername, 
				uuid:uuid, 
				masterId:masterid},
			dataType:'text',
			type:'POST',
			
			success: function(result) {
				alert(result);
				li.remove();
			}
		});
	});

});

function showImage(fileCallPath) {
	$(".bigPicWrapper").css("display", "flex").show();
	$(".bigPic").html("<img src='/fileUpload/display?fileName=" + encodeURI(fileCallPath) + "'>")
	.animate({width:'100%', height:'100%'}, 1000);
}

$(".bigPicWrapper").on("click", function(e){
	$(".bigPic").animate({width:'0%', height:'0%'}, 1000);
	setTimeout(function(){
		$(".bigPicWrapper").hide();
	}, 1000);
});
</script>



	










