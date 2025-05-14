CREATE VIEW V_VehicleFleet AS
SELECT Vehicles.Id,
VehicleTypes.TypeName,
Vehicles.LicensePlate,
Vehicles.VehicleModel,
Vehicles.VehicleMake,
Vehicles.Capacity,
VehicleStatuses.StatusName,
Vehicles.IntroducedAt,
Vehicles.WriteOffAt,
Vehicles.PathWayId,
PathWay.StartLocation,
PathWay.EndLocation,
Assets.Id AS AssetId,
Assets.Address FROM Vehicles
LEFT JOIN VehicleTypes ON Vehicles.TypeId = VehicleTypes.Id
LEFT JOIN VehicleStatuses ON Vehicles.StatusId = VehicleStatuses.Id
LEFT JOIN PathWay ON Vehicles.PathWayId = PathWay.Id
LEFT JOIN Assets ON Vehicles.AssetId = Assets.Id