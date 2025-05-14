CREATE PROCEDURE sp_GetRepairCostAnalysis
@VehicleId INT = NULL,
@VehicleType INT = NULL,
@VehicleMake VARCHAR(50) = NULL,
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
COUNT(DISTINCT TechServices.Id) AS QuantityOfTS,
COUNT(Parts.Id) AS QuantityOfParts,
SUM(Parts.Price) AS PriceSummary
FROM TechServices
INNER JOIN Vehicles ON TechServices.VehicleId = Vehicles.Id
INNER JOIN TechServiceParts ON TechServices.Id = TechServiceParts.TechServiceId
INNER JOIN Parts ON TechServiceParts.PartId = Parts.Id
WHERE(@VehicleId IS NULL OR @VehicleId = Vehicles.Id)
AND (@VehicleType IS NULL OR @VehicleType = Vehicles.TypeId)
AND (@VehicleMake IS NULL OR @VehicleMake = Vehicles.VehicleMake)
AND (YEAR(TechServices.CarriedAt) = @Year)
AND (@Month IS NULL OR MONTH(TechServices.CarriedAt) = @Month)
AND (@Day IS NULL OR DAY(TechServices.CarriedAt) = @Day)
END