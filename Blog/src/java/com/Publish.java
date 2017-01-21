/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author PC
 */
@WebServlet(name = "Publish", urlPatterns = {"/Publish"})
public class Publish extends HttpServlet {

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
                String username = Data.username;
		String title = request.getParameter("title");
		String content = request.getParameter("content");
                request.setAttribute("username", username);
                if(title.equals("")||content.equals("")){
			request.setAttribute("hmsg", "标题或内容不能为空");
			request.getRequestDispatcher("/home.jsp").forward(request, response);
			return;
		}
                Home h = new Home();
                
                h.addpaper(username, title, content);
                request.setAttribute("hmsg", "发表成功");
                
		request.getRequestDispatcher("/home.jsp").forward(request, response);

		
	}

}

