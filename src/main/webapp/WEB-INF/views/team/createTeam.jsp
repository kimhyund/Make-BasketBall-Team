<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@include file="../includes/header.jsp" %>

<div class="card card-plain">
	<div class="row" style="background: #ffffff; padding: 25px; border-radius: 10px;">
	
	 <div class="card-body">
	<div class="col-lg-12">
		<div class="panel panel-default">
			<div class="panel-heading">팀 작성</div>
			<div class="panel-body">
				<form role="form" action="/team/insert.do" method="post">
					<div class="form-group">
						<label>팀이름 : </label><input class="form-control" type="text" name="teamName">
					</div>
					<div class="form-group">
						<label>주소 : </label><input class="form-control" type="text" name="address">
					</div>
					<div class="form-group">
						<label>내용 : </label><textarea class="form-control" name="description" rows="4" cols="50"></textarea>
					</div>
					<input class="btn btn-default" type="submit" value="등록">
					<input class="btn btn-default" type="reset" value="초기화">
				</form>
			</div>
		</div>
	</div>
	</div>
</div>
</div>



<%@include file="../includes/footer.jsp" %>
<script type="text/javascript">

</script>
	