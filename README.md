# A Job-Shop Accounting System

This repository contains a comprehensive database project for a Job-Shop Accounting System, developed for the CS/DSA 4513 Database Management course. The system is designed to manage customers, assemblies, manufacturing processes, jobs, and financial accounts for a special-purpose manufacturing organization.

## Features

The system provides a complete command-line interface and a web application to perform various operations, including:
- **Customer Management:** Add new customers and retrieve customer lists based on categories.
- **Department & Process Management:** Enter new departments and manufacturing processes (cut, paint, fit).
- **Assembly & Job Tracking:** Log new assemblies, associate them with processes, and create/update jobs.
- **Financial Accounting:** Create accounts for assemblies, departments, and processes, and record cost transactions.
- **Data Operations:** Import new customers from a CSV file and export customer data to a CSV file.

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
* Apache Maven
* An IDE (like Eclipse, IntelliJ IDEA, or VS Code)
* Microsoft Azure SQL Database instance
* Apache Tomcat Server (9.0 or higher)
* SQL Server Management Studio (SSMS) or Azure Data Studio

### 2. Database Setup
1.  Connect to your Azure SQL Database instance using SSMS or a similar tool.
2.  Execute the SQL scripts from the `1_database_setup/` folder in the following order:
    1.  `01_create_schema.sql` - Creates all the necessary tables and indexes.
    2.  `02_insert_sample_data.sql` - Populates the tables with initial data for testing.
    3.  `03_stored_procedures.sql` - Creates all the stored procedures used by the applications.

### 3. Java Console Application
1.  Open the `2_java_console_app/` directory in your IDE.
2.  Navigate to `src/com/jobshop/ConsoleApp.java`.
3.  Update the database connection details (hostname, DB name, username, and password) at the top of the file.
4.  Compile and run `ConsoleApp.java`. You can now interact with the system through the console menu.

### 4. JSP Web Application
1.  Configure your Apache Tomcat server in your IDE.
2.  Deploy the `3_jsp_web_app/` project to your Tomcat server.
3.  Ensure the database connection details are updated in the JSP handler files (if applicable).
4.  Start the Tomcat server and navigate to the application URL (e.g., `http://localhost:8080/job-shop-accounting-system/`).
