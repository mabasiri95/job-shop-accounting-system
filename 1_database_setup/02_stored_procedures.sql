-------------------------------------------------------------------------------------------
---Procedure 01 Enter a new customer
DROP PROCEDURE IF EXISTS option_1; 
GO
CREATE PROCEDURE option_1 
    @Names VARCHAR(20),
    @Addresses VARCHAR(20),
    @Category INT
AS
BEGIN
INSERT INTO Customer (Names, Addresses, Category) VALUES (@Names, @Addresses, @Category); -- inserting the values
END
--Executing Procedure1
GO
EXEC option_1 @Names = 'Marshall', @Addresses = 'Houston Ave', @Category = 3;
-------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
---Procedure 02 Enter a new department
DROP PROCEDURE IF EXISTS option_2;
GO

CREATE PROCEDURE option_2 
    @Dep_num INT,
    @Dep_data VARCHAR(255)
AS
BEGIN
    INSERT INTO Department (Dep_num, Dep_data) VALUES (@Dep_num, @Dep_data); -- inserting the values
END
GO

--Executing Procedure2
GO
EXEC option_2 @Dep_num = 13, @Dep_data = 'New Department';
-------------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------------
---Procedure 03 Enter new process-id and its department
DROP PROCEDURE IF EXISTS option_3;
GO

CREATE PROCEDURE option_3 
    @CutPaintFit INT,
    @Process_Id INT,
    @Dep_number INT,
    @Process_data VARCHAR(255),
    @Type VARCHAR(50),
    @Information VARCHAR(50)
AS
BEGIN
    INSERT INTO Process (Process_Id, Process_data) VALUES (@Process_Id, @Process_data); -- inserting the values
    IF @CutPaintFit = 1 --if it is cut
        INSERT INTO Process_Cut (Process_Id, Cutting_type, Machine_type) VALUES (@Process_Id, @Type, @Information); -- inserting the values
    IF @CutPaintFit = 2 --if it is paint
        INSERT INTO Process_Paint (Process_Id, Paint_type, Painting_method) VALUES (@Process_Id, @Type, @Information); -- inserting the values
    IF @CutPaintFit = 3 --if it is fit
        INSERT INTO Process_Fit (Process_Id, Fit_type) VALUES (@Process_Id, @Type); -- inserting the values
    INSERT INTO Supervise (Process_Id, Dep_number) VALUES (@Process_Id, @Dep_number);
END
GO

--Executing Procedure3
GO
EXEC option_3 @CutPaintFit = 2, @Process_Id = 4, @Process_data = 'data process a', @Dep_number = 2, @Type = 'Type A', @Information = 'Information';
-------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------
--Procedure 04 Enter new assembly with processes
DROP PROCEDURE IF EXISTS option_4;
GO

CREATE PROCEDURE option_4
    @Assembly_id INT,
    @Customer_name VARCHAR(100),
    @Assembly_details VARCHAR(255),
    @Date_ordered VARCHAR(100),
    @Process_Ids VARCHAR(MAX) -- Allowing user to input Process Ids separated by commas
AS
BEGIN
    -- Inserting into Assembly table
    INSERT INTO Assemblys (Assembly_id, date_of_ordered, Assembly_details)
    VALUES (@Assembly_id, @Date_ordered, @Assembly_details);

    -- Splitting the process IDs string and inserting into Pass_through table
    DECLARE @ProcessId INT;
    DECLARE processIdsCursor CURSOR FOR
    SELECT value FROM STRING_SPLIT(@Process_Ids, ',');

    OPEN processIdsCursor;
    FETCH NEXT FROM processIdsCursor INTO @ProcessId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Assigning each process to the assembly
        INSERT INTO Pass_through (Assembly_id, Process_Id)
        VALUES (@Assembly_id, @ProcessId);

        FETCH NEXT FROM processIdsCursor INTO @ProcessId;
    END

    CLOSE processIdsCursor;
    DEALLOCATE processIdsCursor;

    -- Inserting into Order table associating the assembly with the customer
    INSERT INTO Orders (Assembly_id, Names)
    VALUES (@Assembly_id, @Customer_name);
END
GO

--Executing Procedure4
GO
EXEC option_4 @Assembly_id = 111, @Customer_name = 'Marshall', @Assembly_details = 'Assembly Description', @Date_ordered = '2023-11-15', @Process_Ids = '3';

-- Enter a new assembly with its customer-name, assembly-details, assembly-id, date-ordered, and associate it with a specific process by providing its Process_Id.
------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------
--Procedure: Create new account and associate with an entity
DROP PROCEDURE IF EXISTS option_5;
GO

CREATE PROCEDURE option_5
    @Account_number INT,
    @Established_date DATE,
    @Details DECIMAL(10,2),
    @Entity_type VARCHAR(20), -- 'process', 'assembly', or 'department'
    @Entity_id INT -- Process_Id, Assembly_id, or Dep_num based on Entity_type
AS
BEGIN
    -- Inserting into Account table
    INSERT INTO Account (Account_number, Established_date)
    VALUES (@Account_number, @Established_date);

    IF @Entity_type = 'process'
    BEGIN
        -- Associate account with a process
        INSERT INTO Process_account (Account_number, details_3)
        VALUES (@Account_number, @Details);
        INSERT INTO Record_cost3 (Account_number, Process_Id)
        VALUES (@Account_number, @Entity_id);
    END
    ELSE IF @Entity_type = 'assembly'
    BEGIN
        -- Associate account with an assembly
        INSERT INTO Assembly_account (Account_number, details_1)
        VALUES (@Account_number, @Details);
        INSERT INTO Record_cost1 (Account_number, Assembly_id)
        VALUES (@Account_number, @Entity_id);
    END
    ELSE IF @Entity_type = 'department'
    BEGIN
        -- Associate account with a department
        INSERT INTO Department_account (Account_number, details_2)
        VALUES (@Account_number, @Details);
        INSERT INTO Record_cost2 (Account_number, Dep_number)
        VALUES (@Account_number, @Entity_id);
    END
END
GO

--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_5 @Account_number = 101, @Established_date = '2023-11-15', @Details = 999.00, @Entity_type = 'process', @Entity_id = 1;

-- Create a new account and associate it with a specific entity (process, assembly, or department) by providing entity's ID and type.
-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
-- Procedure for Option 6: Enter a new job
DROP PROCEDURE IF EXISTS option_6;
GO

CREATE PROCEDURE option_6
    @Job_no INT,
    @Assembly_id INT,
    @Process_Id INT,
    @Commence_Date DATE
AS
BEGIN
    -- Inserting into job table
    INSERT INTO job (Job_no, Commence_Date)
    VALUES (@Job_no, @Commence_Date);

    -- Inserting into Assign table to associate job with assembly and process
    INSERT INTO Assign (Assembly_id, Process_Id, Job_number)
    VALUES (@Assembly_id, @Process_Id, @Job_no);
END
GO


--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_6 @Job_no = 101, @Assembly_id = 2, @Process_Id = 2, @Commence_Date = '2020-01-05';
-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
-- Procedure for Option 7: Complete a job
DROP PROCEDURE IF EXISTS option_7;
GO

CREATE PROCEDURE option_7
    @Job_no INT,
    @Completed_Date DATE,
    @Job_type VARCHAR(20),
    @labor_time INT,
    @Job_details1 VARCHAR(50),
    @Job_details2 VARCHAR(50),
    @Job_details3 INT
AS
BEGIN
    -- Updating the Completed_Date in job table
    UPDATE job
    SET Completed_Date = @Completed_Date
    WHERE Job_no = @Job_no;

    -- Inserting job details based on job type
    IF @Job_type = 'cut'
    BEGIN
        INSERT INTO Cut_job (Job_no, type_of_machine, amount_of_time, material, labor_time)
        VALUES (@Job_no, @Job_details1, @Job_details3, @Job_details2, @labor_time);
    END
    ELSE IF @Job_type = 'paint'
    BEGIN
        INSERT INTO Paint_job (Job_no, color, volume, labor_time)
        VALUES (@Job_no, @Job_details1, @Job_details3, @labor_time);
    END
    ELSE IF @Job_type = 'fit'
    BEGIN
        INSERT INTO Fit_job (Job_no, labor_time)
        VALUES (@Job_no, @labor_time);
    END
END
GO



--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_7 @Job_no = 101, @Completed_Date = '2020-04-04', @Job_type = 'paint', @labor_time = 5, @Job_details1 = 'details1', @Job_details2 = 'details2', @Job_details3 = 78 ;
-----------------------------------------------------------------------------------------------------------------------------------


--------------------------------------------------------------------------------------------------------------------------------------
-- Procedure 08: Enter a transaction-no and its sup-cost and update all the costs (detail-1, detail-2, detail-3) of the affected accounts by adding sup-cost to their current values of details
DROP PROCEDURE IF EXISTS option_8;
GO

CREATE PROCEDURE option_8
    @TransactionNo INT,
    @SupCost DECIMAL(10, 2),
    @JobNo INT,
    @AccountIdsAssembly VARCHAR(MAX),
    @AccountIdsDepartment VARCHAR(MAX),
    @AccountIdsProcess VARCHAR(MAX)
AS
BEGIN
    -- Inserting into Transactions table
    INSERT INTO Transactions (Transaction_num, Sup_cost) 
    VALUES (@TransactionNo, @SupCost);

    -- Inserting into Record table
    INSERT INTO Record (Transaction_num, Job_number) 
    VALUES (@TransactionNo, @JobNo);

    -- Inserting into Updates table for Assembly accounts
    INSERT INTO Updates (Transaction_num, Account_Number) 
    SELECT @TransactionNo, Account_number FROM Assembly_account WHERE Account_number IN (SELECT value FROM STRING_SPLIT(@AccountIdsAssembly, ','));

    -- Inserting into Updates table for Department accounts
    INSERT INTO Updates (Transaction_num, Account_Number) 
    SELECT @TransactionNo, Account_number FROM Department_account WHERE Account_number IN (SELECT value FROM STRING_SPLIT(@AccountIdsDepartment, ','));

    -- Inserting into Updates table for Process accounts
    INSERT INTO Updates (Transaction_num, Account_Number) 
    SELECT @TransactionNo, Account_number FROM Process_account WHERE Account_number IN (SELECT value FROM STRING_SPLIT(@AccountIdsProcess, ','));

    -- Updating detail-1 in Assembly_account
    UPDATE a
    SET a.details_1 = a.details_1 + @SupCost
    FROM Assembly_account a
    INNER JOIN Updates u ON a.Account_number = u.Account_Number AND u.Transaction_num = @TransactionNo;

    -- Updating detail-2 in Department_account
    UPDATE d
    SET d.details_2 = d.details_2 + @SupCost
    FROM Department_account d
    INNER JOIN Updates u ON d.Account_number = u.Account_Number AND u.Transaction_num = @TransactionNo;

    -- Updating detail-3 in Process_account
    UPDATE p
    SET p.details_3 = p.details_3 + @SupCost
    FROM Process_account p
    INNER JOIN Updates u ON p.Account_number = u.Account_Number AND u.Transaction_num = @TransactionNo;
END
GO


--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_8 @TransactionNo = 500, @SupCost = 32.00, @JobNo = 2, @AccountIdsAssembly = '1,2', @AccountIdsDepartment = '1,2', @AccountIdsProcess = '2';
-----------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------
-- Procedure9: Retrieve details-1 on an assembly-id
DROP PROCEDURE IF EXISTS option_9;
GO

CREATE PROCEDURE option_9
    @Assembly_id INT
AS
BEGIN
    SELECT a.details_1
    FROM Assembly_account a
    WHERE a.Account_number = (
        SELECT Account_number
        FROM Record_cost1
        WHERE Assembly_id = @Assembly_id
    );
END
GO



--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_9 @Assembly_id = 1 ;
-----------------------------------------------------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------------------------------
-- Procedure10: Retrieve the total labor time within a department for jobs completed in the department during a given date
DROP PROCEDURE IF EXISTS option_10;
GO

CREATE PROCEDURE option_10
    @Dep_number INT, -- Input parameter: Department number
    @Completion_Start_Date DATE, -- Input parameter: Start date for job completion
    @Completion_End_Date DATE -- Input parameter: End date for job completion
AS
BEGIN
    -- Select the total labor time for all jobs completed in the department within the given date range
    SELECT 
        SUM(COALESCE(CJ.labor_time, 0) + COALESCE(PJ.labor_time, 0) + COALESCE(FJ.labor_time, 0)) AS TotalLaborTime
    FROM 
        job J WITH(INDEX(idx_Job_CompletedDate)) 
        LEFT JOIN Cut_job CJ ON J.Job_no = CJ.Job_no
        LEFT JOIN Paint_job PJ ON J.Job_no = PJ.Job_no
        LEFT JOIN Fit_job FJ ON J.Job_no = FJ.Job_no
        JOIN Assign A ON J.Job_no = A.Job_number
        JOIN Supervise S ON A.Process_Id = S.Process_Id
    WHERE 
        S.Dep_number = @Dep_number
        AND J.Completed_Date BETWEEN @Completion_Start_Date AND @Completion_End_Date;
END
GO




--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_10 @Dep_number = 1, @Completion_Start_Date = '2005-05-05', @Completion_End_Date = '2035-05-05' ;
-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
-- -- Procedure11: Retrieve processes through which a given assembly-id has passed so far
DROP PROCEDURE IF EXISTS option_11;
GO

CREATE PROCEDURE option_11
    @Assembly_id INT
AS
BEGIN
    SELECT 
        P.Process_Id,
        P.Process_data AS ProcessDescription,
        D.Dep_num AS DepartmentNumber,
        D.Dep_data AS DepartmentDescription,
        J.Commence_Date
    FROM 
        job J
        JOIN Assign A ON J.Job_no = A.Job_number
        JOIN Pass_through PT ON A.Assembly_id = PT.Assembly_id
        JOIN Process P ON PT.Process_Id = P.Process_Id
        JOIN Supervise S ON P.Process_Id = S.Process_Id
        JOIN Department D ON S.Dep_number = D.Dep_num
    WHERE 
        A.Assembly_id = @Assembly_id
    ORDER BY 
        J.Commence_Date;
END
GO


--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_11 @Assembly_id = 1;
-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------
-- Procedure12: Retrieve customers whose category is in a given range
DROP PROCEDURE IF EXISTS option_12;
GO

CREATE PROCEDURE option_12
    @minCategory INT, -- Input parameter: Minimum category
    @maxCategory INT -- Input parameter: Maximum category
AS
BEGIN
    SELECT Names, Addresses, Category
    FROM Customer WITH(INDEX(idx_Customer_Category))
    WHERE Category BETWEEN @minCategory AND @maxCategory
    ORDER BY Names;
END
GO

--Executing the procedure: Create an account and associate it with the relevant entity
GO
EXEC option_12 @minCategory = 2, @maxCategory = 6;
-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------
-- Procedure 13: Delete all cut-jobs whose job-no is in a given range
DROP PROCEDURE IF EXISTS option_13;
GO

CREATE PROCEDURE option_13
    @minJobNumber INT, -- Input parameter: Minimum job number
    @maxJobNumber INT -- Input parameter: Maximum job number
AS
BEGIN
    -- Get the job numbers that will be deleted from Cut_job
    DECLARE @deletedJobNumbers TABLE (Job_no INT);

    -- Insert deleted job numbers into the table variable
    INSERT INTO @deletedJobNumbers (Job_no)
    SELECT Job_no
    FROM Cut_job
    WHERE Job_no BETWEEN @minJobNumber AND @maxJobNumber;

    -- Delete from Cut_job
    DELETE FROM Cut_job
    WHERE Job_no BETWEEN @minJobNumber AND @maxJobNumber;

    -- Delete from record only if it corresponds to a deleted cut-job
    DELETE FROM Record
    WHERE Job_number IN (SELECT Job_no FROM @deletedJobNumbers);

    -- Delete from assign only if it corresponds to a deleted cut-job
    DELETE FROM Assign
    WHERE Job_number IN (SELECT Job_no FROM @deletedJobNumbers);

    -- Delete from job only if it corresponds to a deleted cut-job
    DELETE FROM job
    WHERE Job_no IN (SELECT Job_no FROM @deletedJobNumbers);

END
GO

--Executing the procedure:delete
GO
EXEC option_13 @minJobNumber = 1, @maxJobNumber = 6;
-----------------------------------------------------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------------------------------------------------
-- Procedure14 : Change the color of a given paint job
DROP PROCEDURE IF EXISTS option_14;
GO

CREATE PROCEDURE option_14
    @Job_no INT, -- Input parameter: Job number
    @NewColor VARCHAR(50) -- Input parameter: New color
AS
BEGIN
    UPDATE Paint_job
    SET Color = @NewColor
    WHERE Job_no = @Job_no;
END
GO

--Executing the procedure:update
GO
EXEC option_14 @Job_no = 2, @NewColor = 'Orange';
-----------------------------------------------------------------------------------------------------------------------------------




------------------------------------------------------------------------------------------------------------------
---Procedure 16 for displaying all the customers
DROP PROCEDURE IF EXISTS option_16; 
GO
CREATE PROCEDURE option_16
AS 
BEGIN
    SELECT * FROM Customer; -- selecting all the customer
END; 

---Executing
GO
EXEC option_16; 
------------------------------------------------------------------------------------------------------------------


SELECT * FROM Customer;
SELECT * FROM Department;
SELECT * FROM Process;
    SELECT * FROM Process_Cut;
    SELECT * FROM Process_Paint;
    SELECT * FROM Process_Fit;
SELECT * FROM Supervise;
SELECT * FROM Assemblys;
SELECT * FROM Pass_through;
SELECT * FROM Orders;
SELECT * FROM Account;
    SELECT * FROM Process_account;
    SELECT * FROM Record_cost3;
    SELECT * FROM Assembly_account;
    SELECT * FROM Record_cost1;
    SELECT * FROM Department_account;
    SELECT * FROM Record_cost2;
SELECT * FROM Assign;
SELECT * FROM job;
    SELECT * FROM Cut_job;
    SELECT * FROM Fit_job;
    SELECT * FROM Paint_job;
SELECT * FROM Record;
SELECT * FROM Transactions;
SELECT * FROM Updates;
