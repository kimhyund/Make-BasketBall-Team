<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../assets/css/map.css" rel="stylesheet" type="text/css">
<script type="text/javascript" src="../assets/js/map.js" ></script> 
</head>
<body>
	<div id="myModal" class="modal">
	 
		<!-- Modal content -->
		<div class="modal-content">
		   <span class="close">&times;</span>                                                               
		   <tr>
		   	<td>농구장 이름</td>
		   	<td><input type = "text" name = "name" /></td>
		   </tr>
		   <tr>
		   	<td>농구코트</td>
		   	<td>풀코트<input type = "text" name = "full-court" /></td>
		   	<td>반코트<input type = "text" name = "half-court" /></td></td>
		   </tr>
		   <tr>
		   	<td>주소</td>
		   	<td><!-- 주소 마우스클릭 이벤트로 받아오기 --></td>
		   </tr>
		   <tr>
		   	<td>농구장 소개 </td>
		   	<td><textarea></textarea></td>
		   </tr>			   
		</div>
	
   </div>
</body>
</html>