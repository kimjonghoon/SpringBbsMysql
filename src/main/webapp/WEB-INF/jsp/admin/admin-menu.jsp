<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security"%>
	
<h1><spring:message code="user.admin" /></h1>

<ul>
	<li>
		<ul>
		    <li><a href="/admin?page=1"><spring:message code="user.list" /></a></li>
		</ul>
	</li>
</ul>