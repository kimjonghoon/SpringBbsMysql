<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>500 Error</title>
<meta name="viewport" content="width=device-width, initial-scale=1" />
<meta name="Keywords" content="500 Error" />
<meta name="Description" content="500 Error" />
<link rel="stylesheet" href="/resources/css/en.css" />
<link rel="stylesheet" href="/resources/css/screen.css" type="text/css" />
<link rel="stylesheet" href="/resources/css/print.css" type="text/css" />
<script src="/resources/js/jquery-3.2.1.min.js"></script>
<script src="/resources/js/commons.js"></script>
</head>
<body>
<div id="wrap">
	
	<div id="header">
		<div style="float: left;width: 150px;position: relative;top: 7px;"><a href="/"><img src="/resources/images/ci.gif" alt="java-school" /></a></div>
	</div>
	
	<div id="main-menu" lang="en">
		<%@ include file="./inc/main-menu.jsp" %>
	</div>
	
	<div id="container">
		<div id="content">
<!-- content begin -->
<div id="content-categories">Error</div>
<h2>500</h2>
<p>
500 Error!
</p>
<!-- content end -->
		</div>
	</div>

	<div id="sidebar" lang="en">
		<h1>Error</h1>
	</div>

	<div id="extra">
		<%@ include file="./inc/extra.jsp" %>
	</div>
	
	<div id="footer">
		<ul>
			<li><a href="#">Guide</a></li>
			<li><a href="#">Privacy</a></li>
			<li><a href="#">Email Collection Ban</a></li>
			<li id="company-info">
				Phone : 02-123-5678, Fax : 02-123-5678<br />
				people@ggmail.org<br /> Copyright java-school.net All Rights Reserved.</li>
			<li><a href="#">Map</a></li>
		</ul>
	</div>
	
</div>
</body>
</html>