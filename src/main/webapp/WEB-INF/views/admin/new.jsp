<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<script>
$(document).ready(function () {
    $('#blog-form').submit(function () {
        var id = $('#blog-form input[name*=id]').val();
        var title = $('#blog-form input[name*=title]').val();
        var keywords = $('#blog-form input[name*=keywords]').val();
        var description = $('#blog-form input[name*=description]').val();
        var content = $('#blog-form-ta').val();
        id = $.trim(id);
        title = $.trim(title);
        keywords = $.trim(keywords);
        description = $.trim(description);
        content = $.trim(content);
        if (id.length === 0) {
            alert('<spring:message code="id.empty" />');
            $('#blog-form input[name*=id]').val('');
            return false;
        }
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
        $('#blog-form input[name*=id]').val(id);
        $('#blog-form input[name*=title]').val(title);
        $('#blog-form input[name*=keywords]').val(keywords);
        $('#blog-form input[name*=description]').val(description);
        $('#blog-form-ta').val(content);
    });
});
</script>
<h3><spring:message code="blog.new" /></h3>

<form id="blog-form" action="new" method="post">
    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
    <div>
        <spring:message code="blog.category" /><br />
        <label><input type="radio" name="category" value="java" checked="checked" />Java</label>
        <label><input type="radio" name="category" value="jdbc" />JDBC</label>
        <label><input type="radio" name="category" value="jsp" />JSP</label>
        <label><input type="radio" name="category" value="css-layout" />CSS Layout</label>
        <label><input type="radio" name="category" value="jsp-pjt" />JSP Project</label>
        <label><input type="radio" name="category" value="spring" />Spring</label>
        <label><input type="radio" name="category" value="javascript" />JavaScript</label>
        <label><input type="radio" name="category" value="google-app-engine" />Google Cloud</label>
    </div>
    <div>
        id (<spring:message code="blog.id.desc" />)<br />
        <input type="text" name="id" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.title" /> (<spring:message code="blog.title.desc" />)<br />
        <input type="text" name="title" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.keywords" /> (<spring:message code="blog.keywords.desc" />)<br />
        <input type="text" name="keywords" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.description" /> (<spring:message code="blog.description.desc" />)<br />
        <input type="text" name="description" style="width: 99%;" />
    </div>
    <div>
        <spring:message code="blog.content" />
        <textarea name="content" style="width: 99%; height: 200px;" id="blog-form-ta"></textarea>
    </div>
    <div>
        <input type="submit" value="<spring:message code="blog.post" />" />
    </div>
</form>