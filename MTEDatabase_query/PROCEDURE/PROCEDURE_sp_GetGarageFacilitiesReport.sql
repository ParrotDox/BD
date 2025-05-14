CREATE PROCEDURE sp_GetGarageFacilitiesReport
@VehicleType INT = NULL
AS
BEGIN

SELECT
Assets.Id AS AssetId,
AssetTypes.TypeName,
Assets.Address,
Vehicles.Id AS VehicleId,
Vehicles.LicensePlate
FROM Vehicles INNER JOIN Assets ON Vehicles.AssetId = Assets.Id
LEFT JOIN AssetTypes ON Assets.TypeId = AssetTypes.Id
WHERE (@VehicleType IS NULL OR @VehicleType = Vehicles.Id)
END