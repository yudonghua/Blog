<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String author = request.getParameter("author");//用request得到 
session.setAttribute("author",author);
%> 
<html>
<head>
<title>SELECT 操作</title>
<style type="text/css">

.z{
	font-size:1rem; color:#A1A09C;
}

</style>
</head>
<body>
<!--
JDBC 驱动名及数据库 URL 
数据库的用户名与密码，需要根据自己的设置
useUnicode=true&characterEncoding=utf-8 防止中文乱码
 -->
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8"
     user="root"  password="root"/>
 
<sql:query dataSource="${snapshot}" var="result">
SELECT * from <%=author%>;
</sql:query>
<center><h1><%=author%>的博客</h1></center>
<font color="red" size="2"> ${hmsg}</font>
<table border="1" width="100%">
<tr>
   <th>标题</th>
   <th>内容</th>
</tr>
<c:forEach var="row" items="${result.rows}">
<tr>
    <th><a href="content.jsp?content=${row.content}&title=${row.title}&author=<%=author%>&username=${username}"><c:out value="${row.title}"/></a></th>
    <td><c:out value="${row.content}"/>
    </td>
   
   
    
</tr>
</c:forEach>
</table>

 
</body>
</html>