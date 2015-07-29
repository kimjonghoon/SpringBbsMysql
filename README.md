SpringBbs
=========

BBS using Spring MVC + MyBatis-Spring + Spring-Security + Bean Validation


have to edit
 
1. net.java_school.commons.WebContants.java's UPLOAD_PATH

2. /src/main/resources/log4j.xml 
&lt;param name="File"  value="Full path of log file " /&gt;

3. 
  1) creationg user and database

  $ mysql --user=root --password mysql
  mysql> create user 'java'@'%' identified by 'school';
  mysql> grant all privileges on *.* to 'java'@'%';
  mysql> create database javaschool;
  mysql> exit;
  
  $ mysql --user=java --password javaschool
  mysql>
  
  2) crating tables;
  $ mysql --user=java --password javaschool
  mysql> source /your maven project root/mysql-database.sql 
 
  FYI, refer to http://www.java-school.net/spring/SpringBbs-with-MySql



