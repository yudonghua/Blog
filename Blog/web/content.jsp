<%-- 
    Document   : content
    Created on : 2017-1-18, 11:34:34
    Author     : PC
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
String content = request.getParameter("content");//用request得到 
String title = request.getParameter("title");
String username = request.getParameter("username");
%> 
 <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8"
     user="root"  password="root"/>
 
<sql:query dataSource="${snapshot}" var="result">
    SELECT conment from ${author} where title = '<%=title%>';
</sql:query>
<!DOCTYPE html>
<html>

    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
    <center><h1><%=title%><h1></center>
        <h2><%=content%></h2>
        <form action="Conment" method="post">
            <input type="text" name="title"  style="display: none" value="<%=title%>"/>
            <input type="text" name="username"  style="display: none" value="<%=username%>"/>
            <input type="text" name="author" style="display: none" value="${author}"/>
            <input type="text" name="content" style="display: none" value="<%=content%>"/>
            <p>评论<br><textarea name="conment" cols="50" rows="5"></textarea></p>
            <p><input type="submit" value="发表"  /></p>
        </form>
        <font color="red" size="2"> ${msg}</font>

<c:forEach var="row" items="${result.rows}">
    <div id ="comment" style="display: none">${row.conment}</div>
   

<script lanuage="javascript">
        var co =comment.innerHTML;
        var myobj=eval(co);
        document.write("<h2>评论<h2>");
        for(var i=0;i<myobj.length;i++){
            document.write("<p style='color:red;font-size:10px'>"+myobj[i].name+"</p>");
            document.write("<p style='color:blue;font-size:15px'>"+myobj[i].conment+"</p>");
        }
</script>
</c:forEach>
 </body>
</html>
