SELECT
  candidate_id,
  COUNT(SKILL) AS SKILL_COUNT
FROM candidates
WHERE SKILL IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(SKILL) = 3
ORDER BY CANDIDATE_ID ASC