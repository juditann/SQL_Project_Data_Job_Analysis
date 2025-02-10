SELECT name AS company_name
FROM company_dim
WHERE company_id IN (
    SELECT
            company_id
    FROM 
            job_postings_fact
    WHERE
            job_no_degree_mention = true
);

/*
Find the companies that hae the most job openings.
- Get the total number of job potings per company if (job_postings_fact)
- Return the total number of jobs with the company name (company_dim)
*/

WITH company_job_count AS (
    SELECT
        company_id,
        COUNT(job_id) AS count
    FROM 
        job_postings_fact
    GROUP BY    
        company_id
)

SELECT 
    company_dim.name,
    company_job_count.count
FROM company_dim
LEFT JOIN company_job_count 
    ON company_dim.company_id = company_job_count.company_id
ORDER BY
    count DESC;

SELECT * FROM job_postings_fact
LIMIT 10;