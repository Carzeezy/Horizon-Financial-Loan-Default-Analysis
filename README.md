# Horizon Financial Loan Default Analysis

## scenario
You are a data analyst at a mid-size consumer lending company. Management is concerned about the rising default rate on personal loans and wants data-driven insights to improve the underwriting process. In this project you will explore borrower demographics, loan characteristics, and repayment outcomes to identify the key risk factors that predict loan defaults. This is a foundational credit risk analysis project that mirrors real work done at banks, fintech lenders, and credit unions.

## Project overview
Horizon Financial Group has issued over 600 personal loans across 2024 and 2025. The company has noticed that roughly 1 in 4 loans are defaulting, which is well above their target of 12%. The VP of Risk has asked your team to analyze the existing loan book and borrower data to answer key questions about what is driving defaults.

## Business question
What borrower and loan characteristics are associated with a higher likelihood of loan default at Horizon Financial?

## Tools used
- MySQL for data cleaning exploration and aggregations
- Power BI for data visualization

## Key findings

- Overall performance	146 of 601 loans defaulted, for a 24.29% default rate.
- Credit score	Borrowers with credit scores below 520 had a 49.14% default rate, compared with 11.69% for borrowers with scores of 750 or higher.
- Loan purpose	Wedding loans had the highest default rate at 32.14%.
- Loan amount	The average loan amount was $22,148.25. Defaulted loans averaged $22,570.55—only $422.30 higher.
- Employment length	Borrowers employed for two years or fewer defaulted at 31.11%, versus 22.32% for those employed longer than two years.
- Debt-to-income ratio	Borrowers with a DTI above 43% defaulted at 39.75%.

## Recommendation
Adopt a more cautious lending review for borrowers with a debt-to-income ratio near or above 44.41%. This group has a materially higher default rate and should receive additional affordability review, stricter approval criteria, or risk-based pricing.
Credit score and employment length should also be considered alongside DTI, especially for borrowers with a score below 520 or two years or fewer of employment history.

