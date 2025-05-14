CREATE VIEW V_Transits AS
SELECT
Transits.Id,
Transits.StartedAt,
Transits.EndedAt,
Transits.VehicleId,
Transits.CargoQuantity
FROM Transits