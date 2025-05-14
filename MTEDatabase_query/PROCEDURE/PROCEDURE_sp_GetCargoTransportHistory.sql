CREATE PROCEDURE sp_GetCargoTransportHistory
@VehicleId INT = NULL
AS
BEGIN

SELECT
Transits.Id AS TransitId,
Transits.StartedAt,
Transits.EndedAt,
Transits.CargoQuantity,
Vehicles.Id AS VehicleId,
Vehicles.LicensePlate
FROM Transits INNER JOIN Vehicles ON Transits.VehicleId = Vehicles.Id
WHERE (@VehicleId IS NULL OR @VehicleId = Transits.VehicleId);
END