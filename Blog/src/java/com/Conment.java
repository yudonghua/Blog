/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author PC
 */
@WebServlet(name = "Conment", urlPatterns = {"/Conment"})
public class Conment extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
                HttpSession session = request.getSession();
		String username = request.getParameter("username");
		String title = request.getParameter("title");
		String author  = request.getParameter("author");
                String conment  = request.getParameter("conment");
                Conment c = new Conment();
		String svc =(String) request.getSession().getAttribute("sessionverify");
		String psw =new UserDao().findUsername(username);
		if(conment.equals("")){
			request.setAttribute("msg", "评论不能为空");
			request.getRequestDispatcher("/content.jsp").forward(request, response);
			return;
		}
                c.addconment(author,title,conment,username);
                request.getRequestDispatcher("/content.jsp").forward(request, response);

		
	}
        public JSONArray getconment(String author,String title,String conment,String name){
		String psw = null;
                JSONArray array=null ;
		Connection con =null;
		PreparedStatement pstmt =null;
		int rs=789;
		try {
			String driver ="com.mysql.jdbc.Driver";
			String url ="jdbc:mysql://localhost:3306/mysql?useUnicode=true&characterEncoding=utf-8";
			String user ="root";
			String password ="root";
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
                        Statement stat = con.createStatement();
                        stat.executeUpdate("USE test;");
			String sql = "select conment from "+author+" where title='"+title+"';";
		//	pstmt = con.prepareStatement(sql);
                        ResultSet resultSet=stat.executeQuery(sql);
			if(resultSet.next()){
                            array = JSONArray.fromObject(resultSet.getString("conment"));
                            JSONObject json = JSONObject.fromObject("{name:'"+name+"',conment:'"+conment+"'}");
                            if(array.getJSONObject(0).toString().equals("null"))array.clear();
                            array.add(json);
                        }else{
                            array = null;
                        }
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
				} 
			catch (SQLException e) {		
									}
		}
		return array;
	}
        public void addconment(String author,String title,String conment,String name){
		String psw = null;
		Connection con =null;
		PreparedStatement pstmt =null;
                JSONArray array=getconment(author,title,conment,name);

		try {
			String driver ="com.mysql.jdbc.Driver";
			String url ="jdbc:mysql://localhost:3306/mysql?useUnicode=true&characterEncoding=utf-8";
			String user ="root";
			String password ="root";
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
                        Statement stat = con.createStatement();
                        stat.executeUpdate("USE test;");
			String sql = "update "+author+" set conment = '"+array.toString()+"' where title='"+title+"';";
                        System.out.print(sql);
                        stat.execute(sql);

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			try {
				if(pstmt!=null)pstmt.close();
				if(con!=null)con.close();
				} 
			catch (SQLException e) {		
									}
		}
		return;
	}
//            public static void main(String[] args) {
//                String author="YHD";
//                String title="uuuu";
//                String conment="fdsf";
//                String name="sdfs";
//                Conment c = new Conment();
//		c.addconment(author,title,conment,name);
//		
//	}

}

