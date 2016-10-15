<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<script type="text/javascript">
function goList(page) {
	var form = document.getElementById("listForm");
	form.page.value = page;
	form.submit();
}
function editAccount(email) {
	var form = document.getElementById("editAccountForm");
	form.email.value = email;
	form.submit();
}
function delUser(email) {
	var check = confirm("정말로 삭제하겠습니까?");
	if (check) {
		var form = document.getElementById('delUserForm');
		form.email.value = email;
		form.submit();
	}

}
</script>

<div id="url-navi">Admin - <spring:message code="user.membership" /></div>

<h1><spring:message code="user.list" /></h1>

<table class="table-in-article">
<tr>
	<th style="width: 20px;">No</th>
	<th style="width: 90px;"><spring:message code="user.full.name" /></th>
	<th><spring:message code="user.email" /></th>
	<th style="width: 100px;"><spring:message code="user.mobile" /></th>
	<th style="width: 30px;"><spring:message code="user.authority" /></th>
	<th style="width: 10px;"></th>
</tr>
<c:forEach var="user" items="${list }" varStatus="status">
<tr>
	<td style="text-align: center;">${listItemNo - status.index }</td>
	<td><a href="javascript:editAccount('${user.email }')">${user.name }</a></td>
	<td>${user.email }</td>
	<td>${user.mobile }</td>
	<td>${user.authority }</td>
	<td><a href="javascript:delUser('${user.email }')">X</a></td>
</tr>
</c:forEach>
</table>

<div id="paging">
	
	<c:if test="${prevPage > 0 }">
		<a href="javascript:goList('${prevPage }')">[ <spring:message code="global.prev" /> ]</a>
	</c:if>

	<c:forEach var="i" begin="${firstPage }" end="${lastPage }" varStatus="stat">
		<c:choose>
		<c:when test="${param.page == i}">
			<span class="bbs-strong">${i }</span>
		</c:when>
		<c:otherwise>
			<a href="javascript:goList('${i }')">[ ${i } ]</a>
		</c:otherwise>
		</c:choose>
	</c:forEach>
	
	<c:if test="${nextPage > 0 }">
		<a href="javascript:goList('${nextPage }')">[ <spring:message code="global.next" /> ]</a>
	</c:if>
	
</div>

<form>
	<input type="text" name="search" />
	<input type="hidden" name="page" value="1" />
	<input type="submit" value="<spring:message code="global.search" />" />
</form>
<div style="display: none">
	<form id="listForm">
		<input type="hidden" name="page" />
	</form>
	<form id="editAccountForm" action="/admin/editAccount">
		<input type="hidden" name="page" value="${param.page }" />
		<input type="hidden" name="search" value="${param.search }" />
		<input type="hidden" name="email" />
	</form>
	<form id="delUserForm" action="/admin/delUser" method="post">
		<input type="hidden" name="page" value="${param.page }" />
		<input type="hidden" name="search" value="${param.search }" />
		<input type="hidden" name="email" />
		 <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
	</form>
</div>