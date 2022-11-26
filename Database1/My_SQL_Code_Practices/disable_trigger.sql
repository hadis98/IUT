alter table employees
disable trigger salary_before_update;

alter table employees
disable all;

alter table employees
enable trigger salary_before_update;

alter table employees
enable trigger all;