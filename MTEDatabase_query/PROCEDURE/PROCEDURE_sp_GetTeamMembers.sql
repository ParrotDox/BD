CREATE PROCEDURE sp_GetTeamMembers
@ManagerId INT
AS
BEGIN

IF (@ManagerId IS NULL) BEGIN
RAISERROR('¬веден некорректный идентификатор бригадира', 16, 1)
RETURN
END

SELECT
Employees.Id,
Employees.Forename,
Employees.Surname,
Employees.Patronymic,
EmployeePositions.PositionName
FROM Employees INNER JOIN EmployeePositions ON Employees.PositionId = EmployeePositions.Id
WHERE (@ManagerId = Employees.ManagerId)
END