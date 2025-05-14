CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
Forename VARCHAR(50) NOT NULL CHECK(LEN(Forename) >= 1),
Surname VARCHAR(50) NOT NULL CHECK(LEN(Surname) >= 1),
Patronymic VARCHAR(50) NOT NULL CHECK(LEN(Patronymic) >= 1),
PositionId INT NOT NULL,
ManagerId INT,  -- Self-referential foreign key for recursion
FOREIGN KEY(PositionId) REFERENCES EmployeePositions(Id),
FOREIGN KEY(ManagerId) REFERENCES Employees(Id) ON DELETE SET NULL -- Allows recursion
);

CREATE TABLE Assets(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
TypeId INT NOT NULL,
EmployeeId INT,
ParentAssetId INT,  -- Self-referential foreign key for recursion
Address VARCHAR(100) NOT NULL CHECK(LEN(Address) >= 1),
FOREIGN KEY(TypeId) REFERENCES AssetTypes(Id),
FOREIGN KEY(EmployeeId) REFERENCES Employees(Id) ON DELETE SET NULL,
FOREIGN KEY(ParentAssetId) REFERENCES Assets(Id) ON DELETE NO ACTION  -- Allows recursion
);

CREATE TABLE Brigades(
Id INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
AssetId INT,
EmployeeId INT,
FormedAt DATE DEFAULT CAST(GETDATE() AS DATE) NOT NULL,
FOREIGN KEY(AssetId) REFERENCES Assets(Id) ON DELETE SET NULL,
FOREIGN KEY(EmployeeId) REFERENCES Employees(Id) ON DELETE SET NULL
);

ALTER TABLE Employees ADD BrigadeId INT;
ALTER TABLE Employees
ADD FOREIGN KEY(BrigadeId) REFERENCES Brigades(Id) ON DELETE SET NULL;

CREATE TABLE EmployeesEmployeeProperties(
EmployeeId INT NOT NULL,
PropertyId INT NOT NULL,
Val VARCHAR(100) NOT NULL,
FOREIGN KEY(EmployeeId) REFERENCES Employees(Id),
FOREIGN KEY(PropertyId) REFERENCES EmployeeProperties(Id),
PRIMARY KEY(EmployeeId, PropertyId)
);