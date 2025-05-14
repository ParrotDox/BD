CREATE PROCEDURE sp_GetVehicleMileageReport
@VehicleId INT = NULL,
@VehicleTypeId INT = NULL,
@Year INT = NULL,
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
TechServices.Id AS TS_Id,
TechServices.CarriedAt,
TechServices.Mileage,
VehicleTypes.TypeName,
Vehicles.LicensePlate
FROM TechServices INNER JOIN Vehicles ON TechServices.VehicleId = Vehicles.Id
INNER JOIN VehicleTypes ON Vehicles.TypeId = VehicleTypes.Id
WHERE
(@VehicleId IS NULL OR @VehicleId = Vehicles.Id)
AND (@VehicleTypeId IS NULL OR @VehicleTypeId = VehicleTypes.Id)
AND (YEAR(TechServices.CarriedAt) = @Year)
AND (@Month IS NULL OR MONTH(TechServices.CarriedAt) = @Month)
AND (@Day IS NULL OR DAY(TechServices.CarriedAt) = @Day)
ORDER BY TechServices.CarriedAt DESC;
END