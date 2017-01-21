<%@page import="net.sf.json.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.atg.com/taglibs/json" prefix="json" %> 
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>

<html>
<head>
<title>SELECT 操作</title>
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
SELECT * from json;
</sql:query>
<h1></h1>
<c:forEach var="row" items="${result.rows}">
    <p id="test"> ${snapshot} </p>
    <p id="dd" ></p>
<tr>
    <th><a href="content.jsp?content=${row.content}"><c:out value="${row.id}"/></a></th>
    <td><c:out value="${row.test}"/>
    </td>
<script lanuage="javascript">
       document.write("ddd");
</script>
   
    
</tr>

</c:forEach>
       

 
</body>
</html>
