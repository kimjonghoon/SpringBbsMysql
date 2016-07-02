SpringBbsMysql
=================

BBS using Spring MVC + MyBatis-Spring + Spring-Security + Bean Validation


have to edit
 
1. net.java_school.commons.WebContants.java's UPLOAD_PATH

2. /src/main/resources/log4j.xml 
&lt;param name="File"  value="{Full path of log file}"/&gt;

3. 
  1) create user and database
  $ mysql --user=root --password mysql
  
  mysql&gt; create user 'java'@'%' identified by 'school';
  mysql&gt; grant all privileges on *.* to 'java'@'%';
  mysql&gt; create database javaschool;
  mysql&gt; exit;
  
  $ mysql --user=java --password javaschool
  mysql&gt;
  
  2) create tables;
  $ mysql --user=java --password javaschool
  mysql&gt; source {your maven project root}/mysql-database.sql 
 
  FYI, refer to http://www.java-school.net/spring/SpringBbs-with-MySql
4.
https://dev.mysql.com/downloads/connector/j/
mysql-connector-java-5.1.36-bin.jar -> {TOMCAT_HOME}/lib  



