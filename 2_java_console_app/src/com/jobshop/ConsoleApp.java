import java.sql.Connection;
import java.math.BigDecimal;
import java.util.Scanner;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.io.BufferedReader;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;



public class sample {

    // Database credentials
    final static String HOSTNAME = "basi0011-sql-server.database.windows.net";
    final static String DBNAME = "cs-dsa-4513-sql-db";
    final static String USERNAME = "YOUR_DATABASE_USERNAME";
    final static String PASSWORD = "YOUR_DATABASE_PASSWORD";

    // Database connection string
    final static String URL = String.format("jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
            HOSTNAME, DBNAME, USERNAME, PASSWORD);


    // User input prompt//
    final static String PROMPT = 
            "\nPlease select one of the options below: \n" +
            "1) Insert new Customer (option1); \n" + 
            "2) Insert new Department (option2); \n" +
            "3) Enter a new process-id and its department (option3); \n" +
            "4) Enter a new assembly (option4); \n" +
            "5) Create a new account (option5); \n" +
            "6) Enter a new job (option6); \n" +
            "7) Completion of a job (option7); \n" +
            "8) Enter a transaction-no and its sup-cost and update all the costs (option8); \n" +
            "9) Retrieve the total cost incurred on an assembly-id (option9); \n" +
            "10) Retrieve the total labor time within a department (option10); \n" +
            "11) Retrieve the processes through which a given assembly-id (option11); \n" +
            "12) Retrieve the customers whose category is in a given range(option12); \n" +
            "13) Delete all cut-jobs whose job-no is in a given range (option13); \n" +
            "14) Change the color of a given paint job (option14); \n" +
            "15) Import: enter new customers from a data file until the file is empty (option15); \n" +
            "16) Export: Retrieve the customers whose category is in a given range (option16); \n" + 
            "17) Quit!";

    public static void main(String[] args) throws SQLException {

        System.out.println("Welcome to the sample application!");

        final Scanner sc = new Scanner(System.in); // Scanner is used to collect the user input
        String option = ""; // Initialize user option selection as nothing
        while (!option.equals("4")) { // As user for options until option 3 is selected
            System.out.println(PROMPT); // Print the available options
            option = sc.next(); // Read in the user option selection

            switch (option) { // Switch between different options
                case "1": // Insert a new Customer  option
                    // Collect the new performer data from user 
                    System.out.println("Please enter Customer Name:");
                    sc.nextLine();
                    final String Names = sc.nextLine(); // Read in the user input of Customer Name

                    System.out.println("Please enter Customer Address:");
                    final String Addresses = sc.nextLine(); // Read in the user input of Customer Address

                    System.out.println("Please enter Customer category:");
                    final int Category = sc.nextInt(); // Read in user input of Customer category

                   
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_1 @Names = ?, @Addresses = ?, @Category = ?;")) { //calling option_1 query 
                            statement.setString(1, Names); //inserting data
                            statement.setString(2, Addresses);
                            statement.setInt(3, Category);
                          

                            System.out.println("Dispatching the query...");
                            
                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements 
                            statement.executeUpdate(); //want to insert values into query first
                            
                            
                            //close statements 
                            statement.close();

                            connection.close();

                        }
                        
                    } 
                    break;
                case "2": // Insert a new Department  option
                    // Collect the new department data from user 
                    System.out.println("Please enter Department Number:");
                    final int Dep_num = sc.nextInt(); // Read in the user input of department Number

                    System.out.println("Please enter Department data:");
                    sc.nextLine();
                    final String Dep_data = sc.nextLine(); // Read in the user input of Department Data

                   
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_2 @Dep_num = ?, @Dep_data = ?;")) { //calling option_2 query 
                            statement.setInt(1, Dep_num); //inserting data
                            statement.setString(2, Dep_data);
                          

                            System.out.println("Dispatching the query...");
                            
                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements 
                            statement.executeUpdate(); //want to insert values into query first
                            
                            
                            //close statements 
                            statement.close();

                            connection.close();

                        }
                        
                    } 
                    break;
                case "3": // Insert a new Department  option
                    // Collect the new process-id and its department 
                    System.out.println("Please enter 1 for cut, 2 for paint and 3 for fit:");
                    final int CutPaintFit = sc.nextInt(); // Read in the user input of Process ID
                	
                    System.out.println("Please enter Process ID:");
                    final int Process_Id = sc.nextInt(); // Read in the user input of Process ID
                    
                    System.out.println("Please enter Department number:");
                    final int Dep_number = sc.nextInt(); // Read in the user input of Dep_number

                    System.out.println("Please enter Process data:");
                    sc.nextLine();
                    final String Process_data = sc.nextLine(); // Read in the user input of Process Data

                    System.out.println("Please enter Type:");
                    final String Type = sc.nextLine(); // Read in the user input of Type

                    System.out.println("Please enter the information of Machine Type(cut) or Painting method(paint):");
                    final String Information = sc.nextLine(); // Read in the user input of Information

                   
                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_3 @CutPaintFit = ?, @Process_Id = ?, @Dep_number = ?, @Process_data = ?, @Type = ?, @Information = ?;")) { //calling option_3 query 
                            statement.setInt(1, CutPaintFit); //inserting data
                        	statement.setInt(2, Process_Id); //inserting data
                            statement.setInt(3, Dep_number); //inserting data
                            statement.setString(4, Process_data);
                            statement.setString(5, Type);
                            statement.setString(6, Information);
                          

                            System.out.println("Dispatching the query...");
                            
                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements 
                            statement.executeUpdate(); //want to insert values into query first
                            
                            
                            //close statements 
                            statement.close();

                            connection.close();

                        }
                        
                    } 
                    break;
                case "4": // Insert a new Assembly option
                    // Collect the new Assembly and its association
                    System.out.println("Please enter Assembly ID:");
                    final int assemblyId4 = sc.nextInt(); // Read in the user input of Assembly ID

                    System.out.println("Please enter Customer name:");
                    sc.nextLine();
                    final String customerName4 = sc.nextLine(); // Read in the user input of Customer name

                    System.out.println("Please enter Assembly details:");
                    final String assemblyDetails = sc.nextLine(); // Read in the Assembly details

                    System.out.println("Please enter the Date_ordered:");
                    final String dateOrdered = sc.nextLine();

                    // Read in the user input of Process IDs separated by commas
                    System.out.println("Please enter Process IDs separated by commas:");
                    final String processIdsInput = sc.nextLine();


                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_4 @Assembly_id = ?, @Customer_name = ?, @Assembly_details = ?, @Date_ordered = ?, @Process_Ids = ?;")) {
                            // calling option_4 query
                            statement.setInt(1, assemblyId4); // inserting data
                            statement.setString(2, customerName4); // inserting data
                            statement.setString(3, assemblyDetails); // inserting data
                            statement.setString(4, dateOrdered);
                            statement.setString(5, processIdsInput);

                            System.out.println("Dispatching the query...");

                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements
                            statement.executeUpdate(); // want to insert values into query first

                            // close statements
                            statement.close();
                        }
                    }
                    break;
                case "5": // Insert a new Account option
                    // Collect the new account data from the user
                    System.out.println("Please enter Account Number:");
                    final int Account_number = sc.nextInt(); // Read in the user input of Account Number

                    sc.nextLine();
                    System.out.println("Please enter Established Date:");
                    final String Established_date = sc.nextLine();
                    
                    System.out.println("Please enter Account Details (initial cost):");
                    final BigDecimal Account_details = sc.nextBigDecimal(); // Read in the user input of Account Details

                    sc.nextLine();
                    System.out.println("Please enter Entity Type ('process', 'assembly', or 'department'):");
                    final String Entity_type = sc.nextLine(); // Read in the user input of Entity Type

                    System.out.println("Please enter Entity ID:");
                    final int Entity_id = sc.nextInt(); // Read in the user input of Entity ID

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_5 @Account_number = ?, @Established_date = ?, @Details = ?, @Entity_type = ?, @Entity_id = ?;")) { // calling Create_Account stored procedure
                            statement.setInt(1, Account_number); // inserting data
                            statement.setString(2, Established_date);
                            statement.setBigDecimal(3, Account_details);
                            statement.setString(4, Entity_type);
                            statement.setInt(5, Entity_id);

                            System.out.println("Dispatching the query...");

                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements
                            statement.executeUpdate(); // want to insert values into the query first

                            // close statements
                            statement.close();

                            connection.close();

                        }
                    }
                    break;
                case "6": // Enter a new job
                    // Collect the new job data from user
                    System.out.println("Please enter Job Number:");
                    final int Job_no = sc.nextInt(); // Read in the user input of Job Number

                    System.out.println("Please enter Assembly ID:");
                    final int Assembly_id6 = sc.nextInt(); // Read in the user input of Assembly ID

                    System.out.println("Please enter Process ID:");
                    final int Process_Id6 = sc.nextInt(); // Read in the user input of Process ID

                    System.out.println("Please enter Commence Date (YYYY-MM-DD):");
                    final String Commence_Date = sc.next(); // Read in the user input of Commence Date

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_6 @Job_no = ?, @Assembly_id = ?, @Process_Id = ?, @Commence_Date = ?;")) {
                            statement.setInt(1, Job_no); // Inserting data
                            statement.setInt(2, Assembly_id6);
                            statement.setInt(3, Process_Id6);
                            statement.setString(4, Commence_Date);

                            System.out.println("Dispatching the query...");

                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements
                            statement.executeUpdate();

                            // Close statements
                            statement.close();
                            connection.close();
                        }
                    }
                    break;
                case "7": // Complete a job
                    // Collect the completion data from the user
                    System.out.println("Please enter Job Number:");
                    final int Job_no7 = sc.nextInt(); // Read in the user input of Job Number

                    System.out.println("Please enter Completed Date (YYYY-MM-DD):");
                    final String Completed_Date = sc.next(); // Read in the user input of Completed Date

                    System.out.println("Please enter Job Type (cut/paint/fit):");
                    final String Job_type = sc.next(); // Read in the user input of Job Type

                    System.out.println("Please enter Labor Time:");
                    final int Labor_time = sc.nextInt(); // Read in the user input of Labor Time
                    
                    System.out.println("Please enter Machine Type(cut) or Color(paint):");
                    final String Job_details1 = sc.next(); // Read in the user input of Machine Type(cut) or Color(paint) Details
                    
                    System.out.println("Please enter Material(cut):");
                    final String Job_details2 = sc.next(); // Read in the user input of Material(cut) Details
                    
                    System.out.println("Please enter Amount of time(cut) or Volume(paint):");
                    final int Job_details3 = sc.nextInt(); // Read in the user input of Amount of time(cut) or Volume(paint) Details

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_7 @Job_no = ?, @Completed_Date = ?, @Job_type = ?, @labor_time = ?, @Job_details1 = ?, @Job_details2 = ? , @Job_details3 = ?;")) {
                            statement.setInt(1, Job_no7); // Inserting data
                            statement.setString(2, Completed_Date);
                            statement.setString(3, Job_type);
                            statement.setInt(4, Labor_time); // Inserting data
                            statement.setString(5, Job_details1);
                            statement.setString(6, Job_details2);
                            statement.setInt(7, Job_details3);

                            System.out.println("Dispatching the query...");

                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements
                            statement.executeUpdate();

                            // Close statements
                            statement.close();
                            connection.close();
                        }
                    }
                    break;
                case "8": // Enter a transaction-no and its sup-cost and update all the costs
                    System.out.println("Please enter Transaction Number:");
                    final int transactionNumber = sc.nextInt(); // Read in the user input of Transaction Number

                    System.out.println("Please enter Sup Cost:");
                    final BigDecimal supCost = sc.nextBigDecimal(); // Read in the user input of Sup Cost

                    System.out.println("Please enter Job Number:");
                    final int jobNumber = sc.nextInt(); // Read in the user input of Job Number

                    sc.nextLine(); // Consume the newline character left by sc.nextInt()

                    System.out.println("Please enter Account IDs for Assembly (separated by comma):");
                    final String accountIdsAssembly = sc.nextLine(); // Read in the user input of Account IDs for Assembly

                    System.out.println("Please enter Account IDs for Department (separated by comma):");
                    final String accountIdsDepartment = sc.nextLine(); // Read in the user input of Account IDs for Department

                    System.out.println("Please enter Account IDs for Process (separated by comma):");
                    final String accountIdsProcess = sc.nextLine(); // Read in the user input of Account IDs for Process

                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(
                                "EXEC option_8 @TransactionNo = ?, @SupCost = ?, @JobNo = ?, @AccountIdsAssembly = ?, @AccountIdsDepartment = ?, @AccountIdsProcess = ?;")) {
                            statement.setInt(1, transactionNumber); // Inserting data
                            statement.setBigDecimal(2, supCost);
                            statement.setInt(3, jobNumber);
                            statement.setString(4, accountIdsAssembly);
                            statement.setString(5, accountIdsDepartment);
                            statement.setString(6, accountIdsProcess);

                            System.out.println("Dispatching the query...");

                            // Actually execute the populated query, executeUpdate is for INSERT, DELETE, and UPDATE statements
                            statement.executeUpdate();

                            // Close the statement and connection
                            statement.close();
                            connection.close();
                        }
                    }
                    break;

                case "9": // Retrieve details-1 on an assembly-id
                    // Collect the data from the user
                    System.out.println("Please enter Assembly ID:");
                    final int Assembly_id9 = sc.nextInt(); // Read in the user input of Assembly ID

                    System.out.println("Connecting to the database...");
                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (
                            final PreparedStatement statement = connection.prepareStatement("EXEC option_9 @Assembly_id = ?;")) {
                            statement.setInt(1, Assembly_id9); // Inserting data

                            System.out.println("Dispatching the query...");

                            // Actually execute the populated query, executeQuery is for SELECT statements
                            try (final ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set if needed
                                while (resultSet.next()) {
                                    // Retrieve details-1
                                    BigDecimal details1 = resultSet.getBigDecimal("details_1");
                                    
                                    // Print or use the retrieved data as needed
                                    System.out.println("Details-1 for Assembly ID " + Assembly_id9 + ": " + details1);
                                }
                            }

                            // Close statements
                            statement.close();
                            connection.close();
                        }
                    }
                    break;
                case "10": //Retrieve the total labor time within a department for jobs completed in the department during a given date
                    // Collect the data from the user
                	System.out.println("Please enter Department Number:");
                    final int depNumber = sc.nextInt(); // Read in the user input of Department Number

                    System.out.println("Please enter Start Date for Job Completion (YYYY-MM-DD):");
                    final String completionStartDate = sc.next(); // Read in the user input of Start Date for Job Completion

                    System.out.println("Please enter End Date for Job Completion (YYYY-MM-DD):");
                    final String completionEndDate = sc.next(); // Read in the user input of End Date for Job Completion

                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(
                                "EXEC option_10 @Dep_number = ?, @Completion_Start_Date = ?, @Completion_End_Date = ?;")) {
                            statement.setInt(1, depNumber); // Inserting data
                            statement.setString(2, completionStartDate);
                            statement.setString(3, completionEndDate);

                            System.out.println("Dispatching the query...");

                            // Execute the stored procedure and capture the result set
                            try (final ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set
                                if (resultSet.next()) {
                                    int totalLaborTime = resultSet.getInt("TotalLaborTime");
                                    System.out.println("Total Labor Time: " + totalLaborTime);
                                } else {
                                    System.out.println("No data found.");
                                }
                            }

                            // Close the statement and connection
                            statement.close();
                            connection.close();
                        }
                    }
                    break;
                case "11": // Retrieve processes through which a given assembly-id has passed so far
                    // Collect input data from the user
                    System.out.println("Please enter Assembly ID:");
                    final int assemblyId = sc.nextInt(); // Read in the user input of Assembly ID

                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement("EXEC option_11 @Assembly_id = ?")) {
                            statement.setInt(1, assemblyId); // Set Assembly ID as a parameter

                            System.out.println("Dispatching the query...");

                            // Execute the stored procedure
                            try (final ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set
                                while (resultSet.next()) {
                                    int processId = resultSet.getInt("Process_Id");
                                    String processDescription = resultSet.getString("ProcessDescription");
                                    int departmentNumber = resultSet.getInt("DepartmentNumber");
                                    String departmentDescription = resultSet.getString("DepartmentDescription");
                                    String dateCommenced = resultSet.getString("Commence_Date");

                                    System.out.println("Process ID: " + processId);
                                    System.out.println("Process Description: " + processDescription);
                                    System.out.println("Department Number: " + departmentNumber);
                                    System.out.println("Department Description: " + departmentDescription);
                                    System.out.println("Date Commenced: " + dateCommenced);
                                    System.out.println("-----");
                                }
                            }

                            // Close the statement and connection
                            statement.close();
                            connection.close();
                        }
                    }
                    break;
                case "12": // Retrieve customers whose category is in a given range
                    // Collect input data from the user
                    System.out.println("Please enter the minimum category:");
                    final int minCategory = sc.nextInt(); // Read in the user input of minimum category

                    System.out.println("Please enter the maximum category:");
                    final int maxCategory = sc.nextInt(); // Read in the user input of maximum category

                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement("EXEC option_12 @minCategory = ?, @maxCategory = ?")) {
                            statement.setInt(1, minCategory); // Set minimum category as a parameter
                            statement.setInt(2, maxCategory); // Set maximum category as a parameter

                            System.out.println("Dispatching the query...");

                            // Execute the stored procedure
                            try (final ResultSet resultSet = statement.executeQuery()) {
                                // Process the result set
                                while (resultSet.next()) {
                                    String customerName = resultSet.getString("Names");
                                    String customerAddress = resultSet.getString("Addresses");
                                    int customerCategory = resultSet.getInt("Category");

                                    System.out.println("Customer Name: " + customerName);
                                    System.out.println("Customer Address: " + customerAddress);
                                    System.out.println("Customer Category: " + customerCategory);
                                    System.out.println("-----");
                                }
                            }

                            // Close the statement and connection
                            statement.close();
                            connection.close();
                        }
                    }
                    break;
                case "13": // Delete all cut-jobs whose job-no is in a given range
                    // Collect input data from the user
                    System.out.println("Please enter the minimum job number:");
                    final int minJobNumber = sc.nextInt(); // Read in the user input of minimum job number

                    System.out.println("Please enter the maximum job number:");
                    final int maxJobNumber = sc.nextInt(); // Read in the user input of maximum job number

                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement("EXEC option_13 @minJobNumber = ?, @maxJobNumber = ?")) {
                            statement.setInt(1, minJobNumber); // Set minimum job number as a parameter
                            statement.setInt(2, maxJobNumber); // Set maximum job number as a parameter

                            System.out.println("Dispatching the query...");

                            // Execute the stored procedure
                            int rowsAffected = statement.executeUpdate();

                            System.out.println("Deleted " + rowsAffected + " cut-jobs.");

                            // Close the statement and connection
                            statement.close();
                            connection.close();
                        }
                    }
                    break;
                case "14":
                    System.out.println("Please enter the job number:");
                    int jobNumber14 = sc.nextInt();
                    sc.nextLine(); // Consume the newline character
                    System.out.println("Please enter the new color:");
                    String newColor = sc.nextLine();

                    System.out.println("Connecting to the database...");
                    try (Connection connection = DriverManager.getConnection(URL)) {
                        System.out.println("Dispatching the query...");

                        try (PreparedStatement statement14 = connection.prepareStatement("EXEC option_14 @Job_no = ?, @NewColor = ?;")) {
                            statement14.setInt(1, jobNumber14);
                            statement14.setString(2, newColor);

                            System.out.println("Executing the query...");
                            statement14.executeUpdate();
                            System.out.println("Color updated successfully!");
                        }
                    } catch (SQLException e) {
                        System.out.println("Error executing the query: " + e.getMessage());
                    }
                    break;
                case "15":
                    System.out.println("Please enter the input file name:");
                    final String inputFile = sc.next(); // Read in the user input of the input file name

                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (BufferedReader br = new BufferedReader(new FileReader("/Users/mohammadaminbasiri/eclipse-workspace/SampleAzureSQLProject/" + inputFile + ".csv"))) {
                            String line;
                            String split = ",";

                            while ((line = br.readLine()) != null) {
                                String[] customer = line.split(split);

                                try (final PreparedStatement statement = connection.prepareStatement(
                                        "INSERT INTO Customer (Names, Addresses, Category) VALUES (?, ?, ?)")) {
                                    // Populate the query template with the data collected from the user
                                    statement.setString(1, customer[0]);
                                    statement.setString(2, customer[1]);
                                    statement.setInt(3, Integer.parseInt(customer[2]));

                                    System.out.println("Dispatching the query ...");

                                    // Execute the query
                                    final int rowsInserted = statement.executeUpdate();
                                    System.out.println(String.format("Done. %d rows inserted in customer table.", rowsInserted));
                                }
                            }
                        } catch (FileNotFoundException e) {
                            System.out.println("File not found!");
                            e.printStackTrace();
                        } catch (IOException e) {
                            System.out.println("Error reading file.");
                            e.printStackTrace();
                        }
                    }
                    break;

                case "16":
                    System.out.println("Please enter the lower category:");
                    final int lowerCategory = sc.nextInt(); // Read in the user input of lower category

                    System.out.println("Please enter the upper category:");
                    final int upperCategory = sc.nextInt(); // Read in the user input of upper category

                    System.out.println("Please enter the output file name:");
                    final String outputFile = sc.next(); // Read in the user input of the output file name

                    System.out.println("Connecting to the database...");

                    // Get a database connection and prepare a query statement
                    try (final Connection connection = DriverManager.getConnection(URL)) {
                        try (final PreparedStatement statement = connection.prepareStatement(
                                "SELECT Names as cname, Addresses as caddress, Category FROM Customer WHERE Category BETWEEN ? AND ? ORDER BY Names");
                             PrintWriter writer = new PrintWriter(new FileWriter(outputFile + ".csv"))) {

                            statement.setInt(1, lowerCategory);
                            statement.setInt(2, upperCategory);

                            System.out.println("Dispatching the query ...");

                            // Execute the query
                            try (final ResultSet resultSet = statement.executeQuery()) {
                                while (resultSet.next()) {
                                    StringBuilder sub = new StringBuilder();
                                    String name = resultSet.getString("cname");
                                    sub.append(name);
                                    sub.append(',');
                                    String address = resultSet.getString("caddress");
                                    sub.append(address);
                                    sub.append(',');
                                    int category = resultSet.getInt("Category");
                                    sub.append(category);
                                    sub.append('\n');
                                    writer.write(sub.toString());
                                }

                                System.out.println("Data exported to " + outputFile + ".csv");
                            }
                        }
                    } catch (FileNotFoundException e) {
                        System.out.println("File not found!");
                        e.printStackTrace();
                    } catch (IOException e) {
                        System.out.println("Error writing to file.");
                        e.printStackTrace();
                    }
                    break;
                case "17": // Do nothing, the while loop will terminate upon the next iteration
                    System.out.println("Exiting! Good-buy!");
                    System.exit(0);
                    break;
                default: // Unrecognized option, re-prompt the user for the correct one
                    System.out.println(String.format(
                        "Unrecognized option: %s\n" + 
                        "Please try again!", 
                        option));
                    break;
            }
        }

        sc.close(); // Close the scanner before exiting the application
    }
}