CREATE TABLE Register(
Id INT IDENTITY(1,1) NOT NULL,
UserLogin VARCHAR(50) NOT NULL,
UserPasswordHash VARCHAR(64) NOT NULL,
UserSalt VARCHAR(36),
UserRole VARCHAR(20) NOT NULL DEFAULT 'User'); --Admin, Manager, Employee
-- SHA-256 хэширование