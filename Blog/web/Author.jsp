<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
 
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/index.css"/>
        <link rel="stylesheet" href="css/style.css"/>
        <script type="text/javascript" src="js/jquery1.42.min.js"></script>
        <script type="text/javascript" src="js/jquery.SuperSlide.2.1.1.js"></script>
        <style>img{border-radius:50%;}</style>
        <title>博主</title>
    </head>
    <body>
        <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8"
            user="root"  password="root"/>

        <sql:query dataSource="${snapshot}" var="result">
        SELECT * from test;
        </sql:query>
    <center><h1>博主列表</h1></center>
        <div id="say">
                <c:forEach var="row" items="${result.rows}">

                    <ul class='say_box'>
                            <div style="position:relative; height:200px;">
                                <div style="float:left"><img src="images/author/${row.username}.png" width="200" height="200" alt="博主还没上传照片"/></div>
                                <div style="float:left;margin: 10px 10px 10px 10px;">简介:${row.introduce}</div>
                            </div>
                            <span class='dateview'><a href="show.jsp?author=${row.username}&introduce=${row.introduce}">${row.username}</a></span>
                   </ul>


                </c:forEach>
        </div>
    </body>
</html>
