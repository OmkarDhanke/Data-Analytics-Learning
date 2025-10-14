-- Joints 
-- inner joint, left , right, full, self, cross

-- Inner Join
SELECT emp.name as E_name,emp.salary, managers.manager_name as M_name from emp
INNER JOIN managers
ON emp.manager_id = managers.manager_id;

-- Left join
SELECT e.name as E_name,e.salary, m.manager_name as M_name from emp as e
LEFT JOIN managers as m
ON e.manager_id = m.manager_id;

-- Right Join
SELECT e.name as E_name,e.salary, m.manager_name as M_name from emp as e
RIGHT JOIN managers as m
ON e.manager_id = m.manager_id;

-- Full join (or Full outer join) but as in MySQL there is no full function so we use UNION
SELECT e.name as E_name,e.salary, m.manager_name as M_name from emp as e
LEFT JOIN managers as m
ON e.manager_id = m.manager_id
UNION 
SELECT e.name as E_name,e.salary, m.manager_name as M_name from emp as e
RIGHT JOIN managers as m
ON e.manager_id = m.manager_id;

-- Cross JOIN
SELECT e.id,e.name as e_name,m.manager_name as m_name from emp as e
CROSS JOIN managers as m;

-- Self Join
SELECT e1.id, e1.name , e2.name as M_name, e2.id as M_id FROM emp as e1
join emp as e2
on e1.id = e2.manager_id;