/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class Sjson {
	public String jsontest(String username){
		String psw = null;
		Connection con =null;
		PreparedStatement pstmt =null;
		ResultSet rs = null;
		try {
			String driver ="com.mysql.jdbc.Driver";
			String url ="jdbc:mysql://localhost:3306/mysql";
			String user ="root";
			String password ="root";
			Class.forName(driver);
			con = DriverManager.getConnection(url, user, password);
                        Statement stat = con.createStatement();
                        stat.executeUpdate("USE TEST");
			String sql = "select * from json where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, 1);
			rs = pstmt.executeQuery();
			if(rs==null){
				return null;
			}
			if(rs.next()){
				
                                 psw=(String)rs.getObject("test");
                         //       System.out.print(jsonObject.toString());
                                 JSONObject jsonObject = JSONObject.fromObject(psw);
                                 System.out.print(jsonObject.get("name"));
                       
			}else{
				psw=null;
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
		return psw;
	}
	
	//单独测试使用
	public static void main(String[] args) {
           
	new Sjson().jsontest("sda");

		
	}
	
}
