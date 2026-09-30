-- overview of borrower table
DESCRIBE borrower_profiles;

SELECT *
FROM borrower_profiles;

-- overview of loan table
DESCRIBE loan_applications;

SELECT count(*)
FROM loan_applications;

-- total defaulted loans
SELECT sum(defaulted)
FROM loan_applications;


-- what is the overall default rate %
SELECT round((sum(defaulted)/count(defaulted)) * 100,2) pecentage_of_loans_defaulted
FROM loan_applications;

-- credit score range
SELECT credit_score,
CASE
WHEN credit_score <= 599 then '599 or less'
WHEN credit_score between 600 and 649 then '600-649'
WHEN credit_score between 650 and 699 then '650-699'
WHEN credit_score between 700 and 749 then '700-749'
ELSE '750+'
END AS credit_range
FROM borrower_profiles;


-- count how many defaults are in each range then order it by desc
SELECT
CASE
WHEN credit_score <= 599 then '599 or less'
WHEN credit_score between 600 and 649 then '600-649'
WHEN credit_score between 650 and 699 then '650-699'
WHEN credit_score between 700 and 749 then '700-749'
ELSE '750+'
END AS credit_range, ROUND((SUM(defaulted)/COUNT(defaulted)) * 100,2) pecentage_of_loans_defaulted
FROM borrower_profiles
JOIN loan_applications ON borrower_profiles.borrower_id = loan_applications.borrower_id
GROUP BY credit_range
ORDER BY pecentage_of_loans_defaulted DESC;


-- the range of dti debt-to-income ( what is considered low and mid and high)
SELECT  
  ROUND(AVG(existing_monthly_debt / NULLIF(annual_income / 12, 0) * 100), 2) AS avg_dti,
  ROUND(STDDEV(existing_monthly_debt / NULLIF(annual_income / 12, 0) * 100), 2) AS dti_std_dev,
  ROUND(
    AVG(existing_monthly_debt / NULLIF(annual_income / 12, 0) * 100)
    - STDDEV(existing_monthly_debt / NULLIF(annual_income / 12, 0) * 100),
    2
  ) AS low_cutoff,
  ROUND(
    AVG(existing_monthly_debt / NULLIF(annual_income / 12, 0) * 100)
    + STDDEV(existing_monthly_debt / NULLIF(annual_income / 12, 0) * 100),
    2
  ) AS high_cutoff
FROM borrower_profiles;


-- the range in which the borrowers fall under in their dti
SELECT
  borrower_profiles.borrower_id,
  existing_monthly_debt, loan_applications.defaulted,
  ROUND(annual_income/12, 2) as monthly_income,
  ROUND(existing_monthly_debt / NULLIF((annual_income/12), 0) * 100, 2) AS dti,
  CASE
  WHEN ROUND(existing_monthly_debt / NULLIF((annual_income/12), 0) * 100, 2) < 18 THEN 'low'
  WHEN ROUND(existing_monthly_debt / NULLIF((annual_income/12), 0) * 100, 2) <= 42 THEN 'mid'
  ELSE 'high'
END  AS dti_range
FROM borrower_profiles
JOIN loan_applications on borrower_profiles.borrower_id = loan_applications.borrower_id
ORDER BY dti DESC;

-- the amount of dti range who defaulted
SELECT 
CASE
  WHEN ROUND(existing_monthly_debt / NULLIF((annual_income/12), 0) * 100, 2) < 18 THEN 'low'
  WHEN ROUND(existing_monthly_debt / NULLIF((annual_income/12), 0) * 100, 2) <= 42 THEN 'mid'
  ELSE 'high'
END AS dti_range,  ROUND((SUM(defaulted)/COUNT(defaulted)) * 100,2) pecentage_of_loans_defaulted
FROM borrower_profiles
JOIN loan_applications ON borrower_profiles.borrower_id = loan_applications.borrower_id
GROUP BY dti_range
ORDER BY pecentage_of_loans_defaulted DESC;


-- different unique loan purposes
SELECT *
FROM loan_applications;

SELECT DISTINCT loan_purpose
FROM loan_applications;

-- percentage of loan purposes that are defaulted
SELECT loan_purpose, ROUND((SUM(defaulted)/COUNT(defaulted)) * 100,2) pecentage_of_loans_defaulted
FROM loan_applications
JOIN borrower_profiles ON borrower_profiles.borrower_id = loan_applications.borrower_id
GROUP BY loan_purpose
ORDER BY pecentage_of_loans_defaulted DESC;


-- average loan, averge loan defaulted, average loan not defaulted
SELECT ROUND(avg(loan_amount),2) AS avg_loan_amount
from loan_applications;
  
SELECT ROUND(avg(loan_amount),2) AS avg_loan_amount_defaulted
FROM loan_applications
WHERE defaulted = 1;

SELECT ROUND(avg(loan_amount),2) AS avg_loan_amount_not_defaulted
FROM loan_applications
WHERE defaulted = 0;

-- count of defaults in people who have been employed less that 2 yrs vs more that 2 yrs

SELECT SUM(defaulted) 
FROM loan_applications;



SELECT ROUND((SUM(defaulted)/COUNT(defaulted)) * 100,2) AS defaults_under_2_years_employed
FROM loan_applications
WHERE borrower_id IN (
    SELECT borrower_id
    FROM borrower_profiles
    WHERE years_employed <= 2
  );

SELECT ROUND((SUM(defaulted)/COUNT(defaulted)) * 100,2) AS defaults_over_2_years_employed
FROM loan_applications
WHERE borrower_id IN (
    SELECT borrower_id
    FROM borrower_profiles
    WHERE years_employed > 2
  );
  
  -- different employment statuses in the borrower table
SELECT *
FROM borrower_profiles;

SELECT DISTINCT employment_status
FROM borrower_profiles;

-- percentage of employment statues that are defaulted
SELECT employment_status, ROUND((SUM(defaulted)/COUNT(defaulted)) * 100,2) pecentage_of_loans_defaulted
FROM borrower_profiles
JOIN loan_applications ON borrower_profiles.borrower_id = loan_applications.borrower_id
GROUP BY employment_status
ORDER BY pecentage_of_loans_defaulted DESC;