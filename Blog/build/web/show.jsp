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
String introduce = request.getParameter("introduce");
session.setAttribute("author",author);
session.setAttribute("introduce",introduce);
%> 
<sql:setDataSource var="snapshot" driver="com.mysql.jdbc.Driver"
     url="jdbc:mysql://localhost:3306/test?useUnicode=true&characterEncoding=utf-8"
     user="root"  password="root"/>
 
<sql:query dataSource="${snapshot}" var="result">
SELECT * from <%=author%>;
</sql:query>


<html>
    <head>
            <meta charset="UTF-8"/>
            <title>个人博客</title>
            <meta name="keywords" content="个人博客" />
            <meta name="description" content="" />
            <link rel="stylesheet" href="css/index.css"/>
            <link rel="stylesheet" href="css/style.css"/>
            <script type="text/javascript" src="js/jquery1.42.min.js"></script>
            <script type="text/javascript" src="js/jquery.SuperSlide.2.1.1.js"></script>
    </head>

<body>
    <div id="header">
      <h1>个人博客</h1>
      <p>青春是打开了,就合不上的书。人生是踏上了，就回不了头的路，爱情是扔出了，就收不回的赌注。</p>    
    </div>
    <div id="content">
         <!--left-->
         <div class="left" id="c_left">
                <div class="s_tuijian">
                <h2>作者<span>文章</span></h2>
                </div>
               <c:forEach var="row" items="${result.rows}">
                <div class="content_text">
                <!--wz-->
                    <div class="wz">
                     <h3><a href="content.jsp?content=${row.content}&title=${row.title}&author=<%=author%>&username=${username}" title="${row.title}">${row.title}</a></h3>
                      <dl>
                        <dt><img src="images/s.jpg" width="200"  height="123" alt=""></dt>
                        <dd>
                          <p class="dd_text_1">${row.content}</p>
                            <p class="dd_text_2">
                            <span class="left author"><%=author%></span><span class="left sj">时间:2017-1-21</span>
                            <span class="left fl">分类:<a href="#">######</a></span>
                            <span class="left yd"><a href="content.jsp?content=${row.content}&title=${row.title}&author=<%=author%>&username=${username}" title="阅读全文">阅读全文</a>
                            </span>
                             <div class="clear"></div>
                            </p>
                            </dd>
                            <div class="clear"></div>
                          </dl>
                     </div>
                </div>
                </c:forEach>


        </div>
        <div class="right" id="c_right">
            <div class="s_about" >
                   <h2>关于博主</h2>
                    <img src="images/author/<%=author%>.png" width="230" height="230" alt="博主"/>
                    <p>ID:  <%=author%></p>
                    <p>简介： <%=introduce%></p>
            </div>
        </div>

    </div>

</body>
</html>
