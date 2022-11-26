-- show list of indexs
SELECT
    tablename,
    indexname,
    indexdef
FROM
    pg_indexes
WHERE
    schemaname = 'public'
ORDER BY
    tablename,
    indexname;


create index index_FilmTitle on film using hash(title);   
explain analyze select *
from film
where title='Chamber Italian';