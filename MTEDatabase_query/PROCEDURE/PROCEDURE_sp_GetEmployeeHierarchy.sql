CREATE PROCEDURE sp_GetEmployeeHierarchy
AS
BEGIN
SELECT
Employees.Id,
Employees.Forename,
Employees.Surname,
Employees.Patronymic,
EmployeePositions.PositionName,
Employees.ManagerId
FROM Employees INNER JOIN EmployeePositions ON Employees.PositionId = EmployeePositions.Id
END