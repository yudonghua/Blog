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
        <title>JSP Page</title>
    </head>
    <body>
        <sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
            url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8"
            user="root"  password="root"/>

        <sql:query dataSource="${snapshot}" var="result">
        SELECT * from TEST;
        </sql:query>
        <table border="1" width="100%">
            <tr>
               <th>作者列表</th>
            </tr>
            <c:forEach var="row" items="${result.rows}">
                <tr>
                    <th><a href="show.jsp?author=${row.username}"><c:out value="${row.username}"/></a></th>
                 </tr>
            </c:forEach>
        </table>
    </body>
</html>
