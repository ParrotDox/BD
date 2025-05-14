CREATE PROCEDURE sp_GetDriverVehicleDistribution
AS
SELECT
EmployeeVehicles.VehicleId,
Vehicles.LicensePlate,
EmployeeVehicles.EmployeeId,
Employees.Forename,
Employees.Surname,
Employees.Patronymic
FROM EmployeeVehicles
INNER JOIN Vehicles ON EmployeeVehicles.VehicleId = Vehicles.Id
INNER JOIN Employees ON EmployeeVehicles.EmployeeId = Employees.Id;