package com.emerlet.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class ConnectionProvider {
	public static Connection getConnection() {
		Connection conn = null; 
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String username = "c##toilet";
			String password = "toilet";
			
			Class.forName(driver); 
			conn = DriverManager.getConnection(url, username, password); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn; 
	}
	
	public static void close(Connection conn, Statement stmt) {
		try {
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close(); 
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	public static void close(Connection conn, Statement stmt, ResultSet rs) {
		try {
			if (rs != null) {
				rs.close();
			}
			if (stmt != null) {
				stmt.close();
			}
			if (conn != null) {
				conn.close(); 
			}
		} catch (Exception e) {
			//System.out.println();
			e.printStackTrace();
		}
		
	}
	
	
	
	// DB 이니셜 셋팅
    public static Connection getConnection(String user, String pwd) throws Exception {
    	Connection conn = null; 
		try {
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:XE";
			String username = user;
			String password = pwd;
			
			Class.forName(driver); 
			conn = DriverManager.getConnection(url, username, password); 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn; 
    }

	
}

