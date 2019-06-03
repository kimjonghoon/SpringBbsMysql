<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ page import="com.google.appengine.api.users.User" %>
<%@ page import="com.google.appengine.api.users.UserService" %>
<%@ page import="com.google.appengine.api.users.UserServiceFactory" %>
<%@ page import="net.java_school.commons.WebContants" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="security" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%
String url = "";
String english = "";
String korean = "";
String qs = request.getQueryString();
if (qs != null) {
    if (qs.indexOf("&lang=") != -1) {
        qs = qs.substring(0, qs.indexOf("&lang="));
    }
    if (qs.indexOf("lang=") != -1) {
        qs = qs.substring(0, qs.indexOf("lang="));
    }
    if (!qs.equals("")) {
        String decodedQueryString = java.net.URLDecoder.decode(request.getQueryString(), "UTF-8");
        url = "?" + decodedQueryString;
        if (url.indexOf("&lang=") != -1) {
            url = url.substring(0, url.indexOf("&lang="));
        }
        english = url + "&lang=en";
        korean = url + "&lang=ko";
    } else {
        english = url + "?lang=en";
        korean = url = "?lang=ko";
    }
} else {
    english = url + "?lang=en";
    korean = url = "?lang=ko";
}

pageContext.setAttribute("english", english);
pageContext.setAttribute("korean", korean);

UserService userService = UserServiceFactory.getUserService();
%>
<div style="float: left;width: 150px;position: relative;top: 7px;"><a href="/"><img src="/resources/images/ci.gif" alt="java-school" /></a></div>
<div id="memberMenu" style="float: right;position: relative;top: 7px;" lang="en">
	<security:authorize access="isAuthenticated()">
	    <security:authentication property="principal.email" var="emailCheck" />
	    <security:authentication property="principal.nickname" var="nicknameCheck" />
	</security:authorize>

    <c:choose>
        <c:when test="${empty emailCheck}">
            <input type="button" value="<spring:message code="user.login" />" onclick="location.href = '<%=userService.createLoginURL(WebContants.GO_TO_PAGE_AFTER_LOGIN) %>'" />
		</c:when>
        <c:otherwise>
            <span style="color: #999;font-family: Verdana, sans-serif;font-weight: bold;font-size: 12px;">Hello, ${nicknameCheck }!</span> <input type="button" value="<spring:message code="user.logout" />" onclick="location.href='/logout'" />
        </c:otherwise>
	</c:choose>    
</div>
<div id="localeChangeMenu" style="float: right;position: relative;top: 7px;margin-right: 10px;">
    <input type="button" value="English" onclick="location.href = '${english}'" />
    <input type="button" value="Korean" onclick="location.href = '${korean }'" />
</div>