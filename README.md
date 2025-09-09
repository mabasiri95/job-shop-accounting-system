# A Job-Shop Accounting System

This repository contains a comprehensive database project for a Job-Shop Accounting System, developed for the CS/DSA 4513 Database Management course. The system is designed to manage customers, assemblies, manufacturing processes, jobs, and financial accounts for a special-purpose manufacturing organization.

## Features

The system provides two main interfaces for interacting with the database:

**1. Java Console Application:**
* **Full CRUD Operations:** Allows for creating, retrieving, updating, and deleting records across all database tables.
* **Customer Management:** Add new customers and retrieve lists based on categories.
* **Department & Process Management:** Enter new departments and manufacturing processes (cut, paint, fit).
* **Assembly & Job Tracking:** Log new assemblies, associate them with processes, and create/complete jobs.
* **Financial Accounting:** Create accounts for assemblies, departments, and processes, and record cost transactions against jobs.
* **Data Import/Export:** Import new customers from a CSV file and export existing customers to a CSV file.

**2. JSP Web Application:**
* **Add New Customer:** A user-friendly web form to insert a new customer into the database.
* **View All Customers:** Displays all customers currently in the database in a clean, tabular format.

## Technologies Used

* **Backend:** Java, JDBC
* **Database:** Microsoft Azure SQL Database
* **Web:** JavaServer Pages (JSP), Apache Tomcat
* **Database Schema:** The project includes a full ER diagram and relational schema design, available in the project report.

## Repository Structure

```
job-shop-accounting-system/
│
├── 1_database_setup/       # SQL scripts for DB creation
├── 2_java_console_app/     # Source for the Java console application
├── 3_jsp_web_app/          # Source for the JSP web application
└── 4_project_report/       # The original PDF project report
```



## Setup and Installation

### 1. Prerequisites
* Java JDK (11 or higher)
* An IDE (like Eclipse, IntelliJ IDEA, or VS Code)
* Microsoft Azure SQL Database instance
* Apache Tomcat Server (9.0 or higher)
* SQL Server Management Studio (SSMS) or Azure Data Studio

### 2. Database Setup
1.  Connect to your Azure SQL Database instance using SSMS.
2.  Execute the SQL scripts from the `1_database_setup/` folder in the following order:
    1.  `01_create_schema_and_data.sql` - Creates all tables, constraints, indexes, and inserts sample data.
    2.  `02_stored_procedures.sql` - Creates all the stored procedures used by the applications.

### 3. Java Console Application (`ConsoleApp.java`)
1.  Open the `2_java_console_app/` directory in your IDE.
2.  Navigate to `src/com/jobshop/ConsoleApp.java`.
3.  Update the `HOSTNAME`, `DBNAME`, `USERNAME`, and `PASSWORD` static variables with your Azure SQL Database credentials.
4.  Compile and run `ConsoleApp.java`. You can now interact with the system through the console menu.

### 4. JSP Web Application
1.  Open the `3_jsp_web_app/` directory as a project in your IDE.
2.  Navigate to the Java handler at `src/main/java/com/jobshop/CustomerHandler.java`.
3.  Update the `HOSTNAME`, `DBNAME`, `USERNAME`, and `PASSWORD` static variables with your credentials.
4.  Deploy the project to your configured Apache Tomcat server.
5.  Start the server and access the application via your browser:
    * **Add Customer Form:** `http://localhost:8080/your-app-name/add_customer_form.jsp`
    * **View All Customers:** `http://localhost:8080/your-app-name/view_all_customers.jsp`


### 4. JSP Web Application
1.  Configure your Apache Tomcat server in your IDE.
2.  Deploy the `3_jsp_web_app/` project to your Tomcat server.
3.  Ensure the database connection details are updated in the JSP handler files (if applicable).
4.  Start the Tomcat server and navigate to the application URL (e.g., `http://localhost:8080/job-shop-accounting-system/`).
