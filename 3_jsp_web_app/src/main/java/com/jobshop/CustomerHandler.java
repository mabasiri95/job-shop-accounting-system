package finalproject;

import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.Connection;
import java.sql.ResultSet;


public class DataHandler {

    private Connection conn;

    // Database credentials
    final static String HOSTNAME = "basi0011-sql-server.database.windows.net";
    final static String DBNAME = "cs-dsa-4513-sql-db";
    final static String USERNAME = "YOUR_DATABASE_USERNAME";
    final static String PASSWORD = "YOUR_DATABASE_PASSWORD";

    // Database connection string
    final static String URL = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
            HOSTNAME, DBNAME, USERNAME, PASSWORD);
    // Initialize and save the database connection
    private void getDBConnection() throws SQLException {
        if (conn != null) {
            return;
        }

        this.conn = DriverManager.getConnection(url);
    }

    // Return the result of selecting everything from the movie_night 
table 
    public ResultSet getAllCustomer() throws SQLException {
        getDBConnection();
        
        final String sqlQuery = "SELECT * FROM Customer;";
        final PreparedStatement stmt = conn.prepareStatement(sqlQuery);
        return stmt.executeQuery();
    }

    // Inserts a record into the movie_night table with the given 
attribute values
    public boolean addcustomer(
            String cname, String caddress, String category) throws 
SQLException {

        getDBConnection(); // Prepare the database connection

        // Prepare the SQL statement
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_1 @Names = ?, @Addresses = ?, @Category = ?;")) { //calling option_1 query 
                            statement.setString(1, Names); //inserting data
                            statement.setString(2, Addresses);
                            statement.setInt(3, Category);
        
        // Execute the query, if only one record is updated, then we 
indicate success by returning true
        return stmt.executeUpdate() == 1;
    }
}
