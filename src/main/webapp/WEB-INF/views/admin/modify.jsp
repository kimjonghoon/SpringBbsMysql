<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
    $(document).ready(function () {
        $('#blog-form').submit(function () {
            var title = $('#blog-form input[name*=title]').val();
            var keywords = $('#blog-form input[name*=keywords]').val();
            var description = $('#blog-form input[name*=description]').val();
            var content = $('#blog-form-ta').val();
            title = $.trim(title);
            keywords = $.trim(keywords);
            description = $.trim(description);
            content = $.trim(content);
            if (title.length === 0) {
                alert('<spring:message code="title.empty" />');
                $('#blog-form input[name*=title]').val('');
                return false;
            }
            if (keywords.length === 0) {
                alert('<spring:message code="keywords.empty" />');
                $('#blog-form input[name*=keywords]').val('');
                return false;
            }
            if (description.length === 0) {
                alert('<spring:message code="description.empty" />');
                $('#blog-form input[name*=description]').val('');
                return false;
            }
            if (content.length === 0) {
                alert('<spring:message code="content.empty" />');
                var content = $('#blog-form-ta').val('');
                return false;
            }
            $('#blog-form input[name*=title]').val(title);
            $('#blog-form input[name*=keywords]').val(keywords);
            $('#blog-form input[name*=description]').val(description);
            $('#blog-form-ta').val(content);
        });
    });
</script>
<h3><spring:message code="blog.modify" /></h3>
<form id="blog-form" action="modify" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <input type="hidden" name="webSafeString" value="${article.keyString }"/>
    <div><spring:message code="blog.title" />:<input type="text" name="title" value="${article.title }"/></div>
    <div><spring:message code="blog.keywords" />:<input type="text" name="keywords" value="${article.keywords }"/></div>
    <div><spring:message code="blog.description" />:<input type="text" name="description" value="${article.description }"/></div>
    <div><textarea name="content" style="width: 99%;height: 300px;" id="blog-form-ta">${article.content }</textarea></div>
    <div><input type="submit" value="<spring:message code="blog.modify" />" /></div>
</form>