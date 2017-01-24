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
import org.apache.struts2.ServletActionContext;

/**
 *
 * @author PC
 */
@WebServlet(name = "Introduce", urlPatterns = {"/Introduce"})
public class Introduce extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
                HttpSession session = request.getSession();
		String introduce = request.getParameter("introduce");
		String username = request.getParameter("username");
                addintroduce(username,introduce);
                request.getRequestDispatcher("/home.jsp").forward(request, response);
		
	}
        public void addintroduce(String username,String introduce){
		String psw = null;
		Connection con =null;
		PreparedStatement pstmt =null;

		try {
			String driver ="com.mysql.jdbc.Driver";
			String url ="jdbc:mysql://localhost:3306/mysql?useUnicode=true&characterEncoding=utf-8";
			String user ="root";
			String password ="root";
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
                        Statement stat = con.createStatement();
                        stat.executeUpdate("USE test;");
			String sql = "update test set introduce = '"+introduce+"' where username='"+username+"';";
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

}

