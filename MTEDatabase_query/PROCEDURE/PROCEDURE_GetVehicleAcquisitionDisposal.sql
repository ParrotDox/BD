CREATE PROCEDURE sp_GetVehicleAcquisitionDisposal
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
Vehicles.Id,
VehicleStatuses.StatusName,
VehicleTypes.TypeName,
Vehicles.LicensePlate,
Vehicles.IntroducedAt,
Vehicles.WriteOffAt
FROM Vehicles INNER JOIN VehicleStatuses ON Vehicles.StatusId = VehicleStatuses.Id
INNER JOIN VehicleTypes ON Vehicles.TypeId = VehicleTypes.Id
WHERE(@Year = YEAR(Vehicles.IntroducedAt) OR @Year = YEAR(Vehicles.WriteOffAt))
AND (@Month IS NULL OR @Month = MONTH(Vehicles.IntroducedAt) OR @Year = MONTH(Vehicles.WriteOffAt))
AND (@Day IS NULL OR @Day = DAY(Vehicles.IntroducedAt) OR @Year = DAY(Vehicles.WriteOffAt))
END