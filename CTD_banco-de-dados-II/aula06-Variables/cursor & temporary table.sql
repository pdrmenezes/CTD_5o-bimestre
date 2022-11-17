/* Procedure + Variables + Cursor + Loop + Temporary Table */

DELIMITER $$
CREATE PROCEDURE insert_employee()
BEGIN
	# Declaring VARIABLES
    DECLARE empl_name VARCHAR(50);
	DECLARE empl_email VARCHAR(50);
    
    # Declaring CURSOR
    DECLARE my_cursor CURSOR FOR SELECT name, email FROM temp_employees;
    
    # Creating TEMPORARY TABLE
    CREATE TEMPORARY TABLE IF NOT EXISTS temp_employees;
    SELECT name, email from employees;
    
    # Opening CURSOR
    OPEN my_cursor;
    
    # Iterating
    addEmployees: LOOP
    FETCH my_cursor INTO empl_name, empl_email;
    CALL insert_employee(empl_name, empl_email);
    END LOOP;
    
    # Closing CURSOR
    CLOSE my_cursor;
END $$
DELIMITER ;
