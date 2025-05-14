CREATE PROCEDURE sp_GetDriversByVehicle
@VehicleId INT
AS
SELECT 
EmployeeVehicles.VehicleId,
Vehicles.LicensePlate,
Employees.Id,
Employees.Forename,
Employees.Surname,
Employees.Patronymic
FROM EmployeeVehicles 
INNER JOIN Vehicles ON EmployeeVehicles.VehicleId = Vehicles.Id
INNER JOIN Employees ON EmployeeVehicles.EmployeeId = Employees.Id
WHERE (@VehicleId IS NULL OR EmployeeVehicles.VehicleId = @VehicleId)