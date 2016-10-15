<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>

<div id="url-navi">Admin - <spring:message code="user.membership" /></div>

<h1><spring:message code="admin.editaccount.heading" /></h1>

<sf:form id="editAccountForm" action="editAccount" method="post" commandName="user">
<sf:hidden path="email" value="${user.email }" />
<sf:errors path="*" cssClass="error" />
<table>
<tr>
	<td><spring:message code="user.full.name" /></td>
	<td>
		<sf:input path="name" value="${user.name }" /><br />
		<sf:errors path="name" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.mobile" /></td>
	<td>
		<sf:input path="mobile" value="${user.mobile }" /><br />
		<sf:errors path="mobile" cssClass="error" />
	</td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
</tr>
</table>
</sf:form>

<hr />

<sf:form id="changePasswdForm" action="changePasswd" method="post" commandName="user">
<sf:hidden path="email" value="${user.email }" />
<sf:errors path="*" cssClass="error" />
<table>
<tr>
	<td><spring:message code="user.password" /></td>
	<td>
		<sf:password path="passwd" /><br />
		<sf:errors path="passwd" cssClass="error" />
	</td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
</tr>
</table>
</sf:form>

<hr />

<sf:form id="changeAuthorityForm" action="changeAuthority" method="post" commandName="user">
<sf:hidden path="email" value="${user.email }" />
<sf:errors path="*" cssClass="error" />
<table>
<tr>
	<td><spring:message code="user.authority" /></td>
	<td>
		<sf:input path="authority" /><br />
		<sf:errors path="authority" cssClass="error" />
	</td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="<spring:message code="global.submit" />" /></td>
</tr>
</table>
</sf:form>

<div style="text-align: right;">
	<form action="/admin">
		<input type="hidden" name="page" value="${param.page }" />
		<input type="hidden" name="search" value="${param.search }" />
		<input type="submit" value="목록" />
	</form>
</div>