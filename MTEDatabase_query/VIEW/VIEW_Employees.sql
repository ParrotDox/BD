CREATE VIEW V_Employees AS
SELECT Employees.Id, 
Employees.Forename, 
Employees.Surname, 
Employees.Patronymic, 
EmployeePositions.PositionName, 
Employees.ManagerId,
Employees.BrigadeId
FROM Employees INNER JOIN EmployeePositions ON Employees.PositionId  = EmployeePositions.Id;