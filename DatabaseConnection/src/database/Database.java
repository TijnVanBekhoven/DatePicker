package database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

/*
 * Database connection class;
 * 
 * First, open connection with openConnection();
 * Then, do CRUD by using push() and pull();
 * Finally, close connection with closeConnection();
 * 
 * Note, the database is not protected against injections;
 */

public class Database {
    private static String connectionUrl = "jdbc:sqlserver://localhost;databaseName=Bibliotheek;integratedSecurity=true;encrypt=true;trustServerCertificate=true;";
    private static Connection con = null;
    private static Statement stmt = null;
    private static ResultSet rs = null;

    // Pull data from database (Read)
    public static ResultSet pull(String sqlCode) {
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(sqlCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return rs;
    }

    // Push data to database (Create, Update, Delete)
    public static void push(String sqlCode) {
        try {
            stmt = con.createStatement();
            stmt.executeUpdate(sqlCode);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Open connection to database
    public static void openConnection() {
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            con = DriverManager.getConnection(connectionUrl);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Close connection to database
    public static void closeConnection() {
        if (rs != null) try { rs.close(); } catch(Exception e) {}
        if (stmt != null) try { stmt.close(); } catch(Exception e) {}
        if (con != null) try { con.close(); } catch(Exception e) {}
    } 
}
