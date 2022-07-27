-- ----------Selecting Database --------------------------------------------------------------------------
USE credit_card;

SELECT * FROM credit_risk_dataset;

-- --------- Preprocessing data table ----------------------------------------------------------------------

  -- Correcting data error

UPDATE credit_risk_dataset
SET person_emp_length = '12' 
WHERE person_emp_length = '123';

-- Creating customer bin 
ALTER TABLE credit_risk_dataset
ADD Age_Group VARCHAR(255);
UPDATE credit_risk_dataset 
SET 
    Age_Group = CASE
        WHEN person_age < 20 THEN 'Below 20'
        WHEN person_age BETWEEN 20 AND 30 THEN '20-30'
        WHEN person_age BETWEEN 30 AND 40 THEN '30-40'
        WHEN person_age BETWEEN 40 AND 50 THEN '40-50'
        WHEN person_age BETWEEN 50 AND 60 THEN '50-60'
        WHEN person_age BETWEEN 60 AND 70 THEN '60-70'
        WHEN person_age BETWEEN 70 AND 80 THEN '70-80'
        WHEN person_age > 80 THEN 'Above 80'
        ELSE 'Not Defined'
    END;
    


-- Creating income group bin 


ALTER TABLE credit_risk_dataset
ADD Income_Group VARCHAR(255);
UPDATE credit_risk_dataset 
SET 
   Income_Group = CASE
        WHEN person_income <10000 THEN 'Below 10000'
        WHEN person_income BETWEEN 10000 AND 20000 THEN '10000-20000'
        WHEN person_income BETWEEN 20000 AND 30000 THEN '20000-30000'
        WHEN person_income BETWEEN 30000 AND 40000 THEN '30000-40000'
        WHEN person_income BETWEEN 40000 AND 50000 THEN '40000-50000'
        WHEN person_income BETWEEN 50000 AND 60000 THEN '50000-60000'
        WHEN person_income BETWEEN 60000 AND 70000 THEN '60000-70000'
        WHEN person_income BETWEEN 70000 AND 80000 THEN '70000-80000'
        WHEN person_income BETWEEN 80000 AND 90000 THEN '80000-90000'
        WHEN person_income BETWEEN 90000 AND 100000 THEN '90000-100000'
        WHEN person_income BETWEEN 100000 AND 150000 THEN '100000-150000'
        WHEN person_income BETWEEN 150000 AND 200000 THEN '150000-200000'
	    WHEN person_income > 200000 THEN 'Above 200000'
        ELSE 'Not Defined'
    END;
    
-- Creating Index

ALTER TABLE credit_risk_dataset
ADD INDEX id (person_age);
 


-- --------- Exploring and Understanding Data ----------------------------------

/*
- Total customers availing loan and total loan issued
- Customers by status
- Customers by Age Group and Income Group
- What are different loan categories?
- sum of loan amount issued to age groups
- sum of loan amount issued to income groups
- Finding interest rate relation with othe categorical variables
*/



-- Total customers availing loan and total loan issued
SELECT COUNT(person_income) 
FROM credit_risk_dataset;


-- Customers by status
-- Note : 0 is non default and 1 is default

SELECT 
    (loan_status), COUNT(loan_status)
FROM
    credit_risk_dataset
GROUP BY loan_status;


-- Customers by Age Group and Income Group
SELECT 
    (Age_Group), COUNT(loan_status)
FROM
    credit_risk_dataset
GROUP BY Age_Group
ORDER BY Age_Group;

SELECT DISTINCT
    (Income_Group), COUNT(loan_status)
FROM
    credit_risk_dataset
GROUP BY Income_Group
ORDER BY Income_Group;


-- What are different loan categories?

SELECT DISTINCT loan_intent  FROM credit_card.credit_risk_dataset;

-- Number of customers issuing loan by category

SELECT DISTINCT loan_intent, Count(loan_intent) FROM credit_card.credit_risk_dataset
GROUP BY loan_intent;

-- Loan amount issued for loan category;

SELECT DISTINCT
    loan_intent, SUM(loan_amnt)
FROM
    credit_card.credit_risk_dataset
GROUP BY loan_intent
ORDER BY loan_amnt DESC;
  
-- Loan amount issued/availed by age group

SELECT DISTINCT
    Age_Group, SUM(loan_amnt)
FROM
    credit_card.credit_risk_dataset
GROUP BY Age_Group
ORDER BY loan_amnt DESC;



-- Avaerage interest rate by each loan category

Select loan_intent, avg(loan_int_rate) from credit_risk_dataset
GROUP BY loan_intent;

-- Avaerage interest rate by each age group and loan category
SELECT 
    Age_Group, loan_intent, AVG(loan_int_rate) AS interest_rate
FROM
    credit_risk_dataset
GROUP BY Age_Group , loan_intent
ORDER BY interest_rate DESC;

-- Avaerage interest rate by each income group and loan category




-- Avaerage interest rate by each age group, income group and loan category

SELECT Age_Group,
    Income_Group,
    loan_intent,
    AVG(loan_int_rate) AS interest_rate
FROM
    credit_risk_dataset
GROUP BY Age_Group , loan_intent
ORDER BY interest_rate DESC;

SELECT Age_Group,
    loan_intent,
    AVG(loan_int_rate) AS interest_rate
FROM
    credit_risk_dataset
GROUP BY loan_intent,Age_Group
ORDER BY interest_rate DESC;



SELECT 
    Income_Group,
    loan_intent,
    AVG(loan_int_rate) AS interest_rate
FROM
    credit_risk_dataset
GROUP BY loan_intent,Income_Group
ORDER BY interest_rate DESC;



-- ---------- Identifying Loan defaulters --------------------------------------------------------------------
SELECT DISTINCT(loan_status), COUNT(loan_status) 
FROM credit_risk_dataset
GROUP BY loan_status;
           -- 0 MEANS DEFAULT AND 1 MEANS NON DEFAULT

SELECT 
    Income_Group,
    loan_intent,
    Age_Group,
    ROUND(AVG(loan_int_rate)) AS interest_rate,
    COUNT(loan_status)
FROM
    credit_risk_dataset
WHERE
    loan_status = 0
GROUP BY Income_Group
ORDER BY loan_intent DESC;

SELECT 
    Age_Group,cb_person_cred_hist_length, Income_Group,
    loan_intent
    from credit_risk_dataset
     where cb_person_default_on_file = 'Y';



SELECT * FROM credit_risk_dataset
-- -----------Conclusion -------------------------------------------------------------------------------------

-- interest rate below 12% has less default