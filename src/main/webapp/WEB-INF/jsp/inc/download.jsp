<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.File" %>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.io.OutputStream" %>
<%@ page import="java.io.FileInputStream" %>
<%@ page import="java.io.IOException" %>
<%@ page import="org.apache.commons.io.FileUtils" %>
<%
request.setCharacterEncoding("UTF-8");
String filename = request.getParameter("filename");

String path = application.getRealPath("/upload");
File file = new File(path + "/" + filename);

response.setContentLength((int) file.length());

String filetype = filename.substring(filename.indexOf(".") + 1, filename.length());
if (filetype.trim().equalsIgnoreCase("txt")) {
        response.setContentType("text/plain");
} else {
        response.setContentType("application/octet-stream");
}

String userAgent = request.getHeader("user-agent");
boolean ie = userAgent.indexOf("MSIE") != -1;
if (ie) {
        filename = URLEncoder.encode(filename, "UTF-8").replaceAll("\\+", " ");
} else {
        filename = new String(filename.getBytes("UTF-8"), "8859_1");
}

response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\";");
/* response.setHeader("Content-Transfer-Encoding", "binary"); */

OutputStream outputStream = response.getOutputStream();

try {
        FileUtils.copyFile(file, outputStream);
} finally {
        outputStream.flush();
}
%>
