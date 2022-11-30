--drop table Sales_details3

SELECT *
INTO Sales_details3
FROM (
  
with sumList AS (
SELECT 
  branchid, 
  productid, 
  day, 
  month, 
  year, 
  SUM(unitsolid) AS unitSum
FROM sales_details2
GROUP BY branchid, productid, day, month, year
),

avgList AS (
SELECT 
  branchid,
  productid,
  (SUM(unitSum)/ (SELECT COUNT(*)
          FROM (SELECT DISTINCT (year, month,day)
              FROM sales_db2) AS internalQuery)) avgUnit
FROM sumList
GROUP BY branchid, productid
),

orderedList AS (
SELECT
  branchid,
  productid,
  day,
  month,
  year,
  unitSum,
  ROW_NUMBER() OVER (ORDER BY unitSum) AS row_n
FROM sumList
),

quartile_breaks AS (
SELECT
  branchid,
  productid,
  day,
  month,
  year,
  unitSum,
  (
  SELECT unitSum AS quartile_break
  FROM orderedList
  WHERE row_n = FLOOR((SELECT COUNT(*) FROM sumList)*0.75)
  ) AS q_three_lower,
  (
  SELECT unitSum AS quartile_break
  FROM orderedList
  WHERE row_n = FLOOR((SELECT COUNT(*) FROM sumList)*0.75) + 1
  ) AS q_three_upper,
  (
  SELECT unitSum AS quartile_break
  FROM orderedList
  WHERE row_n = FLOOR((SELECT COUNT(*) FROM sumList)*0.25)
  ) AS q_one_lower,
  (
  SELECT unitSum AS quartile_break
  FROM orderedList
  WHERE row_n = FLOOR((SELECT COUNT(*) FROM sumList)*0.25) + 1
  ) AS q_one_upper
FROM orderedList
),

iqr AS (
SELECT
  branchid,
  productid,
  day,
  month,
  year,
  unitSum,
  (
  (SELECT MAX(q_three_lower)
      FROM quartile_breaks) +
  (SELECT MAX(q_three_upper)
      FROM quartile_breaks)
  )/2 AS q_three,
  (
  (SELECT MAX(q_one_lower)
      FROM quartile_breaks) +
  (SELECT MAX(q_one_upper)
      FROM quartile_breaks)
  )/2 AS q_one,
  1.5 * ((
  (SELECT MAX(q_three_lower)
      FROM quartile_breaks) +
  (SELECT MAX(q_three_upper)
      FROM quartile_breaks)
  )/2 - (
  (SELECT MAX(q_one_lower)
      FROM quartile_breaks) +
  (SELECT MAX(q_one_upper)
      FROM quartile_breaks)
  )/2) AS outlier_range
FROM quartile_breaks
)

SELECT
  branchid,
  productid,
  day,
  month,
  year, 
  (CASE
    WHEN (
      unitSum >=
      ((SELECT MAX(q_three) FROM iqr) +
      (SELECT MAX(outlier_range) FROM iqr))
       OR 
      unitSum <=
       ((SELECT MAX(q_one) FROM iqr) -
      (SELECT MAX(outlier_range) FROM iqr))
    ) THEN (
      SELECT avgUnit
      FROM avgList
      WHERE (iqr.branchid, iqr.productid) = (avgList.branchid, avgList.productid)
    )
    ELSE unitSum
  END) AS unit_sum
FROM iqr
) as table2