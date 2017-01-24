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

<!DOCTYPE HTML>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<title>碎言碎语</title>
<meta name="keywords" content="个人博客" />
<meta name="description" content="" />
<link rel="stylesheet" href="css/index.css"/>
<link rel="stylesheet" href="css/style.css"/>
<script type="text/javascript" src="js/jquery1.42.min.js"></script>
<script type="text/javascript" src="js/jquery.SuperSlide.2.1.1.js"></script>
<!--[if lt IE 9]>
<script src="js/html5.js"></script>
<![endif]-->
</head>

<body>
    <div>
        <center><h1><%=title%><h1></center>
        <h2><%=content%></h2>
        <div style="text-align: center">
            <form action="Conment" method="post">
                <input type="text" name="title"  style="display: none" value="<%=title%>"/>
                <input type="text" name="username"  style="display: none" value="<%=username%>"/>
                <input type="text" name="author" style="display: none" value="${author}"/>
                <input type="text" name="content" style="display: none" value="<%=content%>"/>
                <br><textarea name="conment" cols="50" rows="5" placeholder="说点什么吧"></textarea>
                <input class='comment' type="submit" value="发表"   />
            </form>
            <font color="red" size="2"> ${msg}</font>
        </div>
    </div>
    <div id="say">
        <c:forEach var="row" items="${result.rows}">
            <div id ="comment" style="display: none">${row.conment}</div>

            <script lanuage="javascript">
                    var co =comment.innerHTML;
                    var myobj=eval(co);
                    document.write("<h2>评论<h2>");
                    for(var i=0;i<myobj.length;i++){
                        document.write("<ul class='say_box'><div class='sy'><p>"+myobj[i].conment+"</p>");
                        document.write("</div><span class='dateview'>"+myobj[i].name+"</span></ul>");
                    }
            </script>
        </c:forEach>
     </div>

</body>
</html>
