-- Drop tables if they exist

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Supervise;
DROP TABLE IF EXISTS Record;
DROP TABLE IF EXISTS Assign;
DROP TABLE IF EXISTS Updates;
DROP TABLE IF EXISTS Record_cost1;
DROP TABLE IF EXISTS Record_cost2;
DROP TABLE IF EXISTS Record_cost3;
DROP TABLE IF EXISTS Pass_through;
DROP TABLE IF EXISTS Cut_job;
DROP TABLE IF EXISTS Paint_job;
DROP TABLE IF EXISTS Fit_job;
DROP TABLE IF EXISTS job;
DROP TABLE IF EXISTS Process_Fit;
DROP TABLE IF EXISTS Process_Paint;
DROP TABLE IF EXISTS Process_Cut;
DROP TABLE IF EXISTS Process;
DROP TABLE IF EXISTS Transactions;
DROP TABLE IF EXISTS Assemblys;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS Assembly_account;
DROP TABLE IF EXISTS Department_account;
DROP TABLE IF EXISTS Process_account;
DROP TABLE IF EXISTS account;


-- Assembly table
CREATE TABLE Assemblys (
    Assembly_id INT PRIMARY KEY,
    Date_of_ordered VARCHAR(100),
    Assembly_details VARCHAR(255)
);
-- Process table
CREATE TABLE Process (
    Process_Id INT PRIMARY KEY,
    Process_data VARCHAR(255)
);

-- Process-Fit table
CREATE TABLE Process_Fit (
    Process_Id INT PRIMARY KEY,
    Fit_type VARCHAR(50),
    FOREIGN KEY (Process_Id) REFERENCES Process(Process_Id)
);

-- Process-Paint table
CREATE TABLE Process_Paint (
    Process_Id INT PRIMARY KEY,
    Paint_type VARCHAR(50),
    Painting_method VARCHAR(50),
    FOREIGN KEY (Process_Id) REFERENCES Process(Process_Id)
);

-- Process-Cut table
CREATE TABLE Process_Cut (
    Process_Id INT PRIMARY KEY,
    Cutting_type VARCHAR(50),
    Machine_type VARCHAR(50),
    FOREIGN KEY (Process_Id) REFERENCES Process(Process_Id)
);

-- Pass-through table
CREATE TABLE Pass_through (
    Assembly_id INT,
    Process_Id INT,
    PRIMARY KEY (Assembly_id, Process_Id),
    FOREIGN KEY (Assembly_id) REFERENCES Assemblys(Assembly_id),
    FOREIGN KEY (Process_Id) REFERENCES Process(Process_Id) 
);

-- Customer table
CREATE TABLE Customer (
    Names VARCHAR(20) PRIMARY KEY,
    Addresses VARCHAR(20),
    Category INT
    CONSTRAINT CHK_Category CHECK (Category BETWEEN 1 AND 10),
);

-- Creating index for category in Customer table
CREATE INDEX idx_Customer_Category ON Customer(Category);

-- Order table
CREATE TABLE Orders (
    Assembly_id INT,
    Names VARCHAR(20),
    PRIMARY KEY (Assembly_id, Names),
    FOREIGN KEY (Assembly_id) REFERENCES Assemblys(Assembly_id),
    FOREIGN KEY (Names) REFERENCES Customer(Names)
);



-- Department table
CREATE TABLE Department (
    Dep_num INT PRIMARY KEY,
    Dep_data VARCHAR(255)
);

-- Supervise table
CREATE TABLE Supervise (
    Process_Id INT,
    Dep_number INT,
    PRIMARY KEY (Process_Id),
    FOREIGN KEY (Process_Id) REFERENCES Process(Process_Id),
    FOREIGN KEY (Dep_number) REFERENCES Department(Dep_num)
);




-- job table
CREATE TABLE job (
    Job_no INT PRIMARY KEY,
    Commence_Date DATE,
    Completed_Date DATE
);

-- Creating index for completed date in job table
CREATE INDEX idx_Job_CompletedDate ON job(Completed_Date);

-- Cut-job table
CREATE TABLE Cut_job (
    Job_no INT PRIMARY KEY,
    type_of_machine VARCHAR(50),
    amount_of_time INT,
    material VARCHAR(100),
    labor_time INT,
    FOREIGN KEY (Job_no) REFERENCES job(Job_no)
);

-- Paint-job table
CREATE TABLE Paint_job (
    Job_no INT PRIMARY KEY,
    color VARCHAR(50),
    volume INT,
    labor_time INT,
    FOREIGN KEY (Job_no) REFERENCES job(Job_no)
);

-- Fit-job table
CREATE TABLE Fit_job (
    Job_no INT PRIMARY KEY,
    labor_time INT,
    FOREIGN KEY (Job_no) REFERENCES job(Job_no)
);




-- Transaction table
CREATE TABLE Transactions (
    Transaction_num INT PRIMARY KEY,
    Sup_cost DECIMAL(10, 2)
);

-- Record table
CREATE TABLE Record (
    Transaction_num INT,
    job_number INT,
    PRIMARY KEY (Transaction_num, job_number),
    FOREIGN KEY (Transaction_num) REFERENCES Transactions(Transaction_num),
    FOREIGN KEY (job_number) REFERENCES job(Job_no)
);

-- Assign table
CREATE TABLE Assign (
    Assembly_id INT,
    Process_Id INT,
    job_number INT,
    PRIMARY KEY (Assembly_id, Process_Id, job_number),
    FOREIGN KEY (Assembly_id, Process_Id) REFERENCES Pass_through(Assembly_id, Process_Id),
    FOREIGN KEY (job_number) REFERENCES job(Job_no)
);


-- Account table
CREATE TABLE Account (
    Account_number INT PRIMARY KEY,
    Established_date DATE
);

-- Assembly-account table
CREATE TABLE Assembly_account (
    Account_number INT,
    details_1 DECIMAL(10, 2),
    PRIMARY KEY (Account_number),
    FOREIGN KEY (Account_number) REFERENCES Account(Account_number)
);

-- Department-account table
CREATE TABLE Department_account (
    Account_number INT,
    details_2 DECIMAL(10, 2),
    PRIMARY KEY (Account_number),
    FOREIGN KEY (Account_number) REFERENCES Account(Account_number)
);

-- Process-account table
CREATE TABLE Process_account (
    Account_number INT,
    details_3 DECIMAL(10, 2),
    PRIMARY KEY (Account_number),
    FOREIGN KEY (Account_number) REFERENCES Account(Account_number)
);

-- Update table
CREATE TABLE Updates (
    Transaction_num INT,
    Account_Number INT,
    PRIMARY KEY (Transaction_num, Account_Number),
    FOREIGN KEY (Transaction_num) REFERENCES Transactions(Transaction_num),
    FOREIGN KEY (Account_Number) REFERENCES Account(Account_number)
);

-- Record-cost1 table
CREATE TABLE Record_cost1 (
    Account_number INT,
    Assembly_id INT,
    PRIMARY KEY (Account_number, Assembly_id),
    FOREIGN KEY (Account_number) REFERENCES Assembly_account(Account_number),
    FOREIGN KEY (Assembly_id) REFERENCES Assemblys(Assembly_id)
);

-- Record-cost2 table
CREATE TABLE Record_cost2 (
    Account_number INT,
    Dep_number INT,
    PRIMARY KEY (Account_number, Dep_number),
    FOREIGN KEY (Account_number) REFERENCES Department_account(Account_number),
    FOREIGN KEY (Dep_number) REFERENCES Department(Dep_num)
);

-- Record-cost3 table
CREATE TABLE Record_cost3 (
    Account_number INT,
    Process_Id INT,
    PRIMARY KEY (Account_number, Process_Id),
    FOREIGN KEY (Account_number) REFERENCES Process_account(Account_number),
    FOREIGN KEY (Process_Id) REFERENCES Process(Process_Id)
);


-- Sample data for Assemblys table
INSERT INTO Assemblys (Assembly_id, Date_of_ordered, Assembly_details) VALUES
(1, '2023-11-01', 'Sample assembly details 1'),
(2, '2023-11-02', 'Sample assembly details 2'),
(3, '2023-11-03', 'Sample assembly details 3');

-- Sample data for Process table
INSERT INTO Process (Process_Id, Process_data) VALUES
(1, 'process 1'),
(2, 'process 2'),
(3, 'process 3');

-- Sample data for Process_Fit table
INSERT INTO Process_Fit (Process_Id, Fit_type) VALUES
(1, 'Type A');

-- Sample data for Process_Paint table
INSERT INTO Process_Paint (Process_Id, Paint_type, Painting_method) VALUES
(2, 'Type X', 'Method A');

-- Sample data for Process_Cut table
INSERT INTO Process_Cut (Process_Id, Cutting_type, Machine_type) VALUES
(3, 'Cut Type 1', 'Machine X');

-- Sample data for Pass_through table
INSERT INTO Pass_through (Assembly_id, Process_Id) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for Customer table
INSERT INTO Customer (Names, Addresses, Category) VALUES
('Customer 1', 'Address 1', 5),
('Customer 2', 'Address 2', 1),
('Customer 3', 'Address 3', 3);

-- Sample data for Orders table
INSERT INTO Orders (Assembly_id, Names) VALUES
(1, 'Customer 1'),
(2, 'Customer 2'),
(3, 'Customer 3');

-- Sample data for Department table
INSERT INTO Department (Dep_num, Dep_data) VALUES
(1, 'Department Data 1'),
(2, 'Department Data 2'),
(3, 'Department Data 3');

-- Sample data for Supervise table
INSERT INTO Supervise (Process_Id, Dep_number) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for job table
INSERT INTO job (Job_no, Commence_Date, Completed_Date) VALUES
(1, '2023-11-01', '2023-11-05'),
(2, '2023-11-02', '2023-11-06'),
(3, '2023-11-03', '2023-11-07');

-- Sample data for Cut_job table
INSERT INTO Cut_job (Job_no, Type_of_machine, Amount_of_time, Material, Labor_time) VALUES
(1, 'Machine A', 10, 'Material A', 40);

-- Sample data for Paint_job table
INSERT INTO Paint_job (Job_no, Color, Volume, Labor_time) VALUES
(2, 'Blue', 150, 50);

-- Sample data for Fit_job table
INSERT INTO Fit_job (Job_no, Labor_time) VALUES
(3, 60);

-- Sample data for Transactions table
INSERT INTO Transactions (Transaction_num, Sup_cost) VALUES
(1, 100.00),
(2, 150.00),
(3, 200.00);

-- Sample data for Record table
INSERT INTO Record (Transaction_num, Job_number) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for Assign table
INSERT INTO Assign (Assembly_id, Process_Id, Job_number) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3);

-- Sample data for account table
INSERT INTO Account (Account_number, Established_date) VALUES
(1, '2023-11-01'),
(2, '2023-11-02'),
(3, '2023-11-03');

-- Sample data for Assembly_account table
INSERT INTO Assembly_account (Account_number, Details_1) VALUES
(1, 100.00);

-- Sample data for Department_account table
INSERT INTO Department_account (Account_number, Details_2) VALUES
(2, 120.00);

-- Sample data for Process_account table
INSERT INTO Process_account (Account_number, Details_3) VALUES
(3, 130.00);

-- Sample data for Updates table
INSERT INTO Updates (Transaction_num, Account_Number) VALUES
(1, 1),
(2, 2),
(3, 3);

-- Sample data for Record_cost1 table
INSERT INTO Record_cost1 (Account_number, Assembly_id) VALUES
(1, 1);

-- Sample data for Record_cost2 table
INSERT INTO Record_cost2 (Account_number, Dep_number) VALUES
(2, 2);

-- Sample data for Record_cost3 table
INSERT INTO Record_cost3 (Account_number, Process_Id) VALUES
(3, 3);
