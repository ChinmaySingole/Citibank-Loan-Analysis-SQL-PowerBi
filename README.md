
#  Citibank Loan Analytics Project

##  Introduction

The **Citibank Loan Analytics Project** aims to improve the loan approval process, customer segmentation, and risk mitigation strategies by analyzing 10,000+ rows of customer and loan data. This end-to-end analytics project leverages **SQL for data extraction**, **Power BI for dashboard visualization**. The project provides actionable insights to help Citibank optimize lending decisions and enhance financial performance.

---

##  Problem Statement

Citibank Finance faced challenges in identifying high-risk applicants, improving loan approval accuracy, and forecasting delinquency trends. With rising default rates and the need to scale operations, the institution sought data-driven solutions to:

- Detect potential loan defaulters early
- Improve approval rates without increasing risk exposure
- Analyze regional and category-wise loan performance
- Enhance customer risk profiling and repayment tracking


**Dataset Link:** https://drive.google.com/file/d/1RqEcf5HQORPrd9Sy4g5PRPzGCH57bCT1/view

---

##  Project Objective

- Analyze customer and loan datasets using SQL to extract patterns and risk factors
- Build interactive Power BI dashboards to monitor performance KPIs
- Use machine learning to predict loan defaults and repayment probability
- Provide strategic recommendations based on data insights

---

## Tools & Technologies Used

- **SQL (MySQL)** : For querying structured data
- **Power BI** : For building multi-page interactive dashboards
- **Excel/CSV** : For handling raw input files

---

##  Project Phases

###  Phase 1: SQL Analysis
Key insights derived from structured queries on 10,000+ rows of loan and customer data:

- **Customer Demographics:** Analyzed 10,000+ records to understand regional behavior and average credit scores
- **Approval Rate Analysis:** Identified a **68.42% approval rate** out of total applications
- **High-Risk Detection:** Flagged **1,826 customers (18.26%)** based on low credit score, high loan amount, and low income
- **Loan Growth Trends:** Discovered **34.7% YoY growth** in Personal Loans from 2020 to 2024
- **Top Performing States:** Ranked states with **>75% approval** and high average loan sizes
- **Default Analysis:** Mapped **3 regions** with **delinquency rates > 20%**

###  Phase 2: Dashboard Visualization (Power BI)

 **Loan Portfolio Overview**:  
-  Total Loans: 10,000+  
-  Total Loan Amount: ₹1.2 Billion  
-  Avg. Loan Size: ₹120,000  
-  Approval Rate: 68.42%  
-  Default Rate: 12.8%

 **Customer Risk Analysis**:  
-  Total Customers: 9,800  
-  Avg. Credit Score: 645  
-  Repayment Rate: 87.2%  
-  High-Risk Customers: 1,826 (18.26%)

 **Loan Performance by Category**:  
-  Top Categories: Home, Personal, Business Loans  
-  Avg. Interest Rates: 13.4% (Personal), 9.8% (Home)  
-  Default Rate by Type: Business Loans highest at 22%  
-  Revenue Leader: Home Loans with ₹75M+

 **Regional Loan Trends**:  
-  Top States: Maharashtra, Karnataka, Gujarat  
-  Regional Growth: West Zone up by 28.6% (2020–2024)  
-  High-Risk Areas: Tier-III & Eastern states with >20% defaults

 **Loan Repayment & Delinquency**:  
-  Avg. Repayment Time: 16 months  
-  Delinquent Loans: 1,280+  
-  Missed Payments Spike: Business loans during Q4 FY23

 **Financial Performance & Forecasting**:  
-  Net Loan Revenue: ₹145 Million  
-  Interest Income: ₹94.6 Million  
-  ML Accuracy: ~92% in default prediction

---

##  Key Insights

-  **Approval Rate**: 68.42% of loan applications approved (6,842 of 10,000)  
-  **High-Risk Customers**: 1,826 borrowers with credit score <600 and income <₹30K  
-  **Top States**: Maharashtra & Karnataka with >75% approval and avg. loan > ₹500K  
-  **Loan Growth**: Personal Loans grew 34.7% YoY (2020–2024)  
-  **Risky Regions**: 3 zones flagged with >20% default rates  
-  **ML Model**: Achieved ~92% accuracy for default prediction  
-  **Top Revenue Source**: Home Loans contributed over ₹75M  
-  **Default Leader**: Business Loans had the highest delinquency at 22%  
-  **Financial Health**: Net revenue from loans reached ₹145M with strong repayment trends

---

##  Recommendations

-  **Improve Risk Scoring Models**: Integrate ML-based scoring into the approval pipeline to reduce defaults
-  **Segment Loan Products**: Customize offerings for high-risk vs. low-risk borrowers
-  **Focus on High-Yield States**: Expand operations in Maharashtra & Karnataka
-  **Enhance Follow-Up Process**: Monitor delinquent loans aggressively and set up early warning systems
-  **Expand Personal Loans**: Support fast-growing segments with robust monitoring
-  **Target Business Loan Risk**: Revisit terms and monitoring for business borrowers

## Future Enhancements

- Integrate **automated ETL pipelines** for real-time data updates  
- Extend ML models to include **employment history, co-applicant risk**, etc.  
- Add **early warning alert system** for high-risk borrowers  
- Embed dashboards in internal CRM tools for 360° customer view 

## Conclusion 
 This project demonstrates end-to-end analytics capability using SQL, Power BI, and machine learning. It not only helped **optimize lending operations** but also supported **data-backed risk management** and **strategic planning** at Citibank Finance.

## Contributions
Contributions are welcome! Feel free to open an issue or submit a pull request.

## License
This project is licensed under the MIT License.
