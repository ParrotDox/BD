CREATE PROCEDURE sp_GetSpecialistWorkReport
@EmployeeId INT = NULL,
@VehicleId INT = NULL,
@Year INT,
@Month INT = NULL,
@Day INT = NULL
AS
BEGIN

IF @Year IS NULL BEGIN
RAISERROR('Год должен быть указан', 16, 1);
RETURN END

IF @Year < 2000 OR @Year > 2100 BEGIN
RAISERROR('Некорректный ввод года', 16, 1);
RETURN END

IF @Month IS NOT NULL AND (@Month < 1 OR @Month > 12) BEGIN
RAISERROR('Некорректный ввод месяца', 16, 1);
RETURN END

IF @Day IS NOT NULL AND (@Day < 1 OR @Day > 31) BEGIN
RAISERROR('Некорректный ввод дня', 16, 1);
RETURN END

SELECT
TechServices.Id AS TechServiceId,
TechServices.EmployeeId,
Employees.Forename,
Employees.Surname,
Employees.Patronymic,
TechServices.CarriedAt,
Vehicles.Id AS VehicleId,
Vehicles.LicensePlate
FROM TechServices INNER JOIN Employees ON TechServices.EmployeeId = Employees.Id
INNER JOIN Vehicles ON TechServices.VehicleId = Vehicles.Id
WHERE(@Year = YEAR(TechServices.CarriedAt))
AND (@Month IS NULL OR @Month = MONTH(TechServices.CarriedAt))
AND (@Day IS NULL OR @Day = DAY(TechServices.CarriedAt))
AND (@EmployeeId IS NULL OR @EmployeeId = TechServices.EmployeeId)
AND (@VehicleId IS NULL OR @VehicleId = TechServices.VehicleId)
END