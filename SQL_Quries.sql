#1 Retrieve the number of unique customers by region and their average credit score

WITH CreditScoreMapping AS (
    SELECT 
        l.customer_id,
        sr.region,
        CASE 
            WHEN l.grade = 'A' THEN 785
            WHEN l.grade = 'B' THEN 700
            WHEN l.grade = 'C' THEN 660
            WHEN l.grade = 'D' THEN 620
            WHEN l.grade = 'E' THEN 580
            WHEN l.grade = 'F' THEN 540
            WHEN l.grade = 'G' THEN 410
            ELSE NULL
        END AS credit_score
    FROM loan l
    JOIN customers c ON l.customer_id = c.customer_id
    JOIN state_region sr ON c.addr_state = sr.state
)
SELECT 
    region,
    COUNT(DISTINCT customer_id) AS unique_customers,
    AVG(credit_score) AS avg_credit_score
FROM CreditScoreMapping
GROUP BY region;



#2 Calculate the percentage of Charged off loans out of the total loan applications.

SELECT 
    (SELECT COUNT(loan_status) 
     FROM loan 
     WHERE loan_status = 'Charged Off') 
    / COUNT(loan_status) * 100 AS 
    "Charged Off Loans %"
FROM loan;



#3 Identify loans with high default risk based on annual income, and loan amount.

WITH CreditScoreCalc AS (
    SELECT 
        l.loan_id,
        c.customer_id,
        c.annual_inc,
        l.loan_amount,
        l.grade,
        CASE 
            WHEN l.grade = 'A' THEN 750
            WHEN l.grade = 'B' THEN 700
            WHEN l.grade = 'C' THEN 650
            WHEN l.grade = 'D' THEN 600
            WHEN l.grade = 'E' THEN 550
            WHEN l.grade = 'F' THEN 500
            ELSE 450 
        END AS credit_score
    FROM loan l
    JOIN customers c ON l.customer_id = c.customer_id
)
SELECT 
    loan_id,
    customer_id,
    annual_inc,
    loan_amount,
    credit_score,
    CASE 
        WHEN credit_score < 600 AND annual_inc < 50000 AND loan_amount > 30000 THEN 'High Risk'
        WHEN (credit_score BETWEEN 600 AND 650) AND (annual_inc BETWEEN 40000 AND 70000) 
        AND (loan_amount BETWEEN 20000 AND 50000) THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS risk_category
FROM CreditScoreCalc
ORDER BY risk_category DESC;



#4 Find the top 5 states with the highest loans and compare them to their average loan amount.
WITH StateLoanStats AS (
    SELECT 
        c.addr_state AS state,
        COUNT(*) AS total_loans,
        AVG(l.loan_amount) AS avg_loan_amount
    FROM loan l
    JOIN customers c ON l.customer_id = c.customer_id
    GROUP BY c.addr_state
),
RankedStates AS (
    SELECT 
        state,
        total_loans,
        avg_loan_amount,
        RANK() OVER (ORDER BY total_loans DESC) AS rank_loans
    FROM StateLoanStats
)
SELECT 
    state,
    total_loans,
    avg_loan_amount
FROM RankedStates
WHERE rank_loans <= 5                    
ORDER BY total_loans DESC;



#5 Analyze loan disbursement trends by year and identify the fastest-growing loan categories.

WITH YearlyLoanData AS (
    SELECT 
        YEAR(issue_date) AS loan_year, 
        purpose AS loan_category,
        SUM(loan_amount) AS total_disbursed
    FROM loan
    GROUP BY YEAR(issue_date), purpose
), 
GrowthCalculation AS (
    SELECT 
        y1.loan_year,
        y1.loan_category,
        y1.total_disbursed,
        y2.total_disbursed AS prev_year_disbursed,
        (y1.total_disbursed - y2.total_disbursed) 
        / NULLIF(y2.total_disbursed, 0) * 100 AS growth_rate
    FROM YearlyLoanData y1
    LEFT JOIN YearlyLoanData y2 
        ON y1.loan_category = y2.loan_category 
        AND y1.loan_year = y2.loan_year + 1
)
SELECT * FROM GrowthCalculation
ORDER BY loan_year DESC, growth_rate DESC;



#6  Analyze customer loan distribution by region and compare their repayment trends.

SELECT 
    sr.Region,
    COUNT(l.loan_id) AS total_loans_issued,
    SUM(CASE
        WHEN l.loan_status = 'Fully Paid' THEN 1
        ELSE 0
    END) AS fully_paid_loans,
    SUM(CASE
        WHEN l.loan_status = 'Current' THEN 1
        ELSE 0
    END) AS current_loans,
    SUM(CASE
        WHEN l.loan_status = 'Late(16-30 days)' THEN 1
        ELSE 0
    END) AS late_loans,
    SUM(CASE
        WHEN l.loan_status = 'Default' THEN 1
        ELSE 0
    END) AS defaulted_loans,
    SUM(CASE
        WHEN l.loan_status = 'In Grace Period' THEN 1
        ELSE 0
    END) AS GracePeriod_loans,
    ROUND((SUM(CASE
                WHEN l.loan_status = 'Fully Paid' THEN 1
                ELSE 0
            END) * 100.0) / COUNT(l.loan_id),
            2) AS repayment_rate
FROM
    loan l
        JOIN
    state_region sr ON l.state = sr.State
GROUP BY sr.Region
ORDER BY total_loans_issued DESC;



#7 Retrieve the average interest rate for loans by loan category and region.

SELECT purpose, region, ROUND(AVG(int_rate), 2) AS avg_interest_rate
FROM loan
JOIN loan_with_region ON loan.loan_id = loan_with_region.loan_id
GROUP BY purpose, region;
# OR THIS
SELECT purpose, region, ROUND(AVG(int_rate) * 100, 2) AS avg_interest_rate_percentage
FROM loan
JOIN loan_with_region ON loan.loan_id = loan_with_region.loan_id
GROUP BY purpose, region;



#8 Identify the most common loan purposes and their default rates.

SELECT 
    purpose,
    COUNT(loan_id) AS total_loans,
    SUM(CASE
        WHEN loan_status IN ('Default' , 'charged off') THEN 1
        ELSE 0
    END) AS No_of_defaulted_loans,
    ROUND((SUM(CASE
                WHEN loan_status IN ('Default' , 'charged off') THEN 1
                ELSE 0
            END) * 100.0) / COUNT(loan_id),2) AS default_rate
FROM
    loan
GROUP BY purpose
ORDER BY total_loans DESC;



#9 Find the correlation between income levels and default probability.

WITH IncomeCategory AS (
    SELECT 
        c.customer_id,
        c.annual_inc,
        CASE 
			WHEN c.annual_inc < 30000 THEN 'Low Income (<30K)'
			WHEN c.annual_inc BETWEEN 30001 AND 60000 THEN 'Middle Income (30K-60K)'
			WHEN c.annual_inc BETWEEN 60001 AND 100000 THEN 'Upper-Middle Income (60K-100K)'
			ELSE 'High Income (100K+)'
		END AS income_bracket,
        COUNT(l.loan_id) AS total_loans,
        COUNT(CASE WHEN l.loan_status = 'Default' THEN 1 END) AS total_defaults
    FROM customers c
    JOIN loan l ON c.customer_id = l.customer_id
    GROUP BY c.customer_id, c.annual_inc
)

SELECT 
    income_bracket,
    COUNT(customer_id) AS total_customers,
    SUM(total_loans) AS total_loans_issued,
    SUM(total_defaults) AS total_defaults,
    ROUND(100.0 * SUM(total_defaults) / NULLIF(SUM(total_loans), 0), 2) AS default_probability
FROM IncomeCategory
GROUP BY income_bracket
ORDER BY default_probability DESC;


# 10.List customers who have missed multiple payments and are at risk of default

SELECT customers.*, loan. loan_status
FROM customers
JOIN loan
ON customers.customer_id = loan.customer_id
WHERE loan. loan_status = 'Late (31-120 days) ' ;
















