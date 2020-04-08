<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@include file="../includes/header.jsp" %>
<div>
	<section class="content container-fluid">
	
		<h3><i class="fa fa-warning text-red"></i>${exception.getMessage()}</h3>
		<ul>
			<c:forEach items="${exception.getStackTrace()}" var="stack">
				<li>${stack}</li>
			</c:forEach>
		</ul>
	</section>
	
</div>
<%@include file="../includes/footer.jsp" %>
	

