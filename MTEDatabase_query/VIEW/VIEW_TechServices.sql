CREATE VIEW V_TechServices
AS
SELECT
TechServices.Id,
TechServices.EmployeeId,
TechServices.VehicleId,
TechServices.CarriedAt,
TechServices.Mileage
FROM TechServices