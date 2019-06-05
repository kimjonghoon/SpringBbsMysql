<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function () {
    $('.blog-modify-link').click(function (e) {
        e.preventDefault();
        var webSafeString = this.title;
        $('#form input[name*=webSafeString]').val(webSafeString);
        $('#form').attr('action', '/admin/modify');
        $('#form').attr('method', 'get');
        $('#form').submit();
    });
    $('.blog-delete-link').click(function (e) {
        e.preventDefault();
        var chk = confirm('<spring:message code="delete.confirm" />');
        if (chk === true) {
            var webSafeString = this.title;
            $('#form input[name*=webSafeString]').val(webSafeString);
            $('#form').attr('action', '/admin/delete');
            $('#form').attr('method', 'post');
            $('#form').submit();
        }
    });
});
</script>
<article>
<h3><spring:message code="blog.list" /></h3>
<p style="text-align: right">
<a href="/admin/new" style="text-transform: capitalize;"><spring:message code="blog.new" /></a>
</p>
<ul id="blog-list">
    <c:forEach var="article" items="${articles }" varStatus="status">
        <li>${article.category }/${article.id } ${article.title }
            <a href="#" title="${article.keyString }" class="blog-modify-link">[<spring:message code="bbs.modify" />]</a> 
            <a href="#" title="${article.keyString }" class="blog-delete-link">[<spring:message code="bbs.delete" />]</a>
        </li>
	</c:forEach>
</ul>
<form id="form">
    <input type="hidden" name="webSafeString" />
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
</form>

</article>