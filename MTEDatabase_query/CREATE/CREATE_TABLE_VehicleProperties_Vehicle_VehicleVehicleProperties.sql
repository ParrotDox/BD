CREATE TABLE VehicleProperties(
Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
PropertyName VARCHAR(50) NOT NULL CHECK(LEN(PropertyName) >= 1)
);

CREATE TABLE Vehicles(
Id INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
TypeId INT NOT NULL,
StatusId INT NOT NULL,
PathWayId INT,
AssetId INT,
LicensePlate VARCHAR(9) UNIQUE NOT NULL  CHECK(LEN(LicensePlate) = 9),
VehicleMake VARCHAR(50) NOT NULL CHECK(LEN(VehicleMake) >= 1),
VehicleModel VARCHAR(50) NOT NULL CHECK(LEN(VehicleModel) >= 1),
Capacity INT NOT NULL CHECK(Capacity > 0),
IntroducedAt DATE NOT NULL,
WriteOffAt DATE,
FOREIGN KEY(TypeId) REFERENCES VehicleTypes(Id),
FOREIGN KEY(StatusId) REFERENCES VehicleStatuses(Id),
FOREIGN KEY(PathWayId) REFERENCES PathWay(Id) ON DELETE SET NULL,
FOREIGN KEY(AssetId) REFERENCES Assets(Id) ON DELETE SET NULL
);

CREATE TABLE VehicleVehicleProperties(
VehicleId INT NOT NULL,
PropertyId INT NOT NULL,
PRIMARY KEY(VehicleId, PropertyId),
FOREIGN KEY(VehicleId) REFERENCES Vehicles(Id),
FOREIGN KEY(PropertyId) REFERENCES VehicleProperties(Id)
);