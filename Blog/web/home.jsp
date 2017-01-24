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
            <style type="text/css">
                .btn{
                    font-size: 14px;
                    color: #fff;
                    background: #00b4ef;
                    border-radius: 30px;
                    padding: 10px 25px;
                    border: none;
                    text-transform: capitalize;
                    transition: all 0.5s ease 0s;
                }
                .edit{

                    text-align:center;
                    border:2px solid #a1a1a1;
                    padding:1px 4px; 
                    background:#dddddd;
                    width:50px;
                    border-radius:25px;
                    -moz-border-radius:25px; /* 老的 Firefox */

                }
                .introduce{
                    background: white;
                    border:none; 
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
SELECT * from ${username};
</sql:query>
<sql:query dataSource="${snapshot}" var="introduce">
SELECT introduce from test where username = '${username}';
</sql:query>
<h1>博客</h1><a href="Author.jsp">查看其他人的博客</a>
<font color="red" size="2"> ${dd}</font>
<div style="text-align: center">
    <div>
        <form action="Publish" method="post">
            <div style="text-align: center">
                <div style="width:90%;"> <input type="text" name="title" class="title"/></div>
                        <br>
                        <textarea name="content" cols="50" rows="5"></textarea>
                        <input class="comment" type="submit" value="发表"  /> 
            </div>
    
        </form>
    </div>
</div>
<font color="red" size="2"> ${hmsg}</font>


 <div id="content">
         <!--left-->
         <div class="left" id="c_left">
                <div class="s_tuijian">
                <h2>我的<span>文章</span></h2>
                </div>
               <c:forEach var="row" items="${result.rows}">
                <div class="content_text">
                <!--wz-->
                    <div class="wz">
                     <h3><a href="content.jsp?content=${row.content}&title=${row.title}&author=${username}&username=${username}" title="${row.title}">${row.title}</a></h3>
                      <dl>
                        <dt><img src="images/s.jpg" width="200"  height="123" alt=""></dt>
                        <dd>
                          <p class="dd_text_1">${row.content}</p>
                            <p class="dd_text_2">
                            <span class="left author">${username}</span><span class="left sj">时间:2017-1-21</span>
                            <span class="left fl">分类:<a href="#">######</a></span>
                            <span class="left yd"><a href="content.jsp?content=${row.content}&title=${row.title}&author=${username}&username=${username}" title="阅读全文">阅读全文</a>
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
                    <img src="images/author/${username}.png" width="230" height="230" alt="博主还没上传照片"/>
                    <div>
                        <form action="Picture?username=${username}" method="post" enctype="multipart/form-data">
                            <input  id="imgch" style="display:none" type="file" name="img" class="file"/>
                            <center><img src="images/add.png" width="50" height="50" alt="+" onclick="select()"/></center>
                            <center><button type="submit" class="btn btn-default">上传</button></center>
                        </form>
                    </div>
                    
                    
                    <p>ID:  ${username}</p>

                        <form action="Introduce" method="post">
                            简介：
                            <c:forEach var="row" items="${introduce.rows}">
                                <input id="introduce" type="text" name="introduce" class="introduce" disabled="ture" value="${row.introduce}"/>
                            </c:forEach>
                            
                            <input type="text" name="username" value="${username}" style="display:none"/>
                            <input id="edit" type="button" class="edit" value="编辑" onclick="edittext()"/>
                            <center><button type="submit" style="display: none"></button></center>
                        </form>

            </div>
        </div>

</div>
<script type="text/javascript">
    function edittext(){$("input").attr("disabled",false);}
    function select(){
        imgch.click();
    }
</script>
 
</body>
</html>