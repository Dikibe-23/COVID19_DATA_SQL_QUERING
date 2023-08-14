
select * from department
select * from employee
select * from project
select * from works_on

--Get the last name of all employees who worked on project 'p3'

select emp_lname from employee
join works_on
on employee.emp_no = works_on.emp_no
where project_no = 'p3'

--Get the first and last name of analyst whose department is located in Seattle

select emp_fname, emp_lname from employee
join works_on
on employee.emp_no = works_on.emp_no
join department
on department.dept_no = employee.dept_no
where location = 'seattle'
and job = 'Analyst'
