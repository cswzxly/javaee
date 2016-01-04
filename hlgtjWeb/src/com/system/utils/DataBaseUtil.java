package com.system.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DataBaseUtil {
	
	 /** 
     * 获取数据库连接 
     * @return Connection 对象 
     */  
    public static Connection getConnection() {  
        Connection conn = null;  
        try {  
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");  
            String url = "jdbc:sqlserver://127.0.0.1:1433;databaseName=kggov";  
            String username = "sa";  
            String password = "1234";   
            conn = DriverManager.getConnection(url, username, password);  
              
        } catch (ClassNotFoundException e) {  
            e.printStackTrace();  
        } catch (SQLException e) {  
            e.printStackTrace();  
        }  
        return conn;  
    }  
      
    public static void closeConn(Connection conn) {  
        if (conn != null) {  
            try {  
                conn.close();  
            } catch (SQLException e) {  
                e.printStackTrace();  
            }  
        }  
    }  
}
