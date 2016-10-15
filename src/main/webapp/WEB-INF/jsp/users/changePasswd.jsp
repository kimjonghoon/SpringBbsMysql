<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="sf" %>
<script type="text/javascript">
function check() {
    var form = document.getElementById("changePassworddForm");
    if (form.newPasswd.value == form.confirm.value) {
    	return true;
    } else {
    	alert('<spring:message code="user.changepasswd.passwd.validation" />');
    	return false;
    }
}
</script>

<div id="url-navi"><spring:message code="user.membership" /></div>

<h1><spring:message code="user.changepasswd.heading" /></h1>
${user.name }<br />
${user.mobile }<br />
<sf:form id="changePassworddForm" action="changePasswd" method="post" 
	commandName="password" onsubmit="return check()">
<table>
<tr>
	<td><spring:message code="user.changepasswd.current.passwd" /></td>
	<td>
		<sf:password path="currentPasswd" /><br />
		<sf:errors path="currentPasswd" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.changepasswd.new.passwd" /></td>
	<td>
		<sf:password path="newPasswd" /><br />
		<sf:errors path="newPasswd" cssClass="error" />
	</td>
</tr>
<tr>
	<td><spring:message code="user.changepasswd.new.passwd.confirm" /></td>
	<td><input type="password" name="confirm" /></td>
</tr>
<tr>
	<td colspan="2"><input type="submit" value="확인" /></td>
</tr>
</table>
</sf:form>