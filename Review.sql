-- Afficher l’id, first_name, last_name des employés qui n’ont pas d’équipe. 

SELECT id, first_name, last_name
FROM employee
WHERE team_id IS NULL;

-- Afficher l’id, first_name, last_name des employés qui n’ont jamais pris de congé de leur vie.

SELECT employee.id, employee.first_name, employee.last_name
FROM employee
LEFT JOIN leave ON leave.employee_id = employee.id
WHERE leave.id IS NULL;

-- Afficher les congés de tel sorte qu’on voie l’id du congé, le début du congé, la fin du congé, le nom & prénom de l’employé qui prend congé et le nom de son équipe.

SELECT 
    leave.id,
    leave.start_date,
    leave.end_date,
    employee.first_name,
    employee.last_name,
    team.name
FROM leave
INNER JOIN employee ON employee.id = leave.employee_id
LEFT JOIN team ON team.id = employee.team_id;

-- Affichez par le nombre d’employés par contract_type, vous devez afficher le type de contrat, et le nombre d’employés associés.

SELECT contract_type.name, COUNT(employee.id) AS employee_count
FROM contract_type
LEFT JOIN employee employee ON employee.contract_type_id = contract_type.id
GROUP BY contract_type.name
ORDER BY contract_type.name;

-- Afficher le nombre d’employés en congé aujourd'hui. La période de congé s'étend de start_date inclus jusqu’à end_date inclus.

SELECT COUNT(DISTINCT employee_id)
FROM leave
WHERE CURRENT_DATE BETWEEN start_date AND end_date;

-- Afficher l’id, le nom, le prénom de tous les employés + le nom de leur équipe qui sont en congé aujourd’hui. Pour rappel, la end_date est incluse dans le congé, l’employé ne revient que le lendemain. 

SELECT 
    employee.id,
    employee.first_name,
    employee.last_name,
    team.name
FROM employee
JOIN leave ON leave.employee_id = employee.id
LEFT JOIN team ON team.id = employee.team_id
WHERE CURRENT_DATE BETWEEN leave.start_date AND leave.end_date;