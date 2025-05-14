CREATE PROCEDURE sp_GetPassengerTransportPathWays
AS
SELECT
Vehicles.Id AS VehicleId,
Vehicles.LicensePlate,
PathWay.Id AS PathWayId,
PathWayTypes.TypeName,
PathWay.StartLocation,
PathWay.EndLocation
FROM Vehicles INNER JOIN PathWay ON Vehicles.PathWayId = PathWay.Id
INNER JOIN PathWayTypes ON PathWay.TypeId = PathWayTypes.Id
WHERE PathWayTypes.TypeName = 'Пассажирский'
ORDER BY PathWay.Id;