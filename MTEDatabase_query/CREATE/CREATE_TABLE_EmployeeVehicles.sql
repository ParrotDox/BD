CREATE TABLE EmployeeVehicles(
EmployeeId INT NOT NULL,
VehicleId INT NOT NULL,
PRIMARY KEY(EmployeeId, VehicleId),
FOREIGN KEY(EmployeeId) REFERENCES Employees(Id),
FOREIGN KEY(VehicleId) REFERENCES Vehicles(Id)
);