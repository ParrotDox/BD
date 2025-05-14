CREATE VIEW V_Assets AS
SELECT Assets.Id,
AssetTypes.TypeName,
Assets.Address,
Assets.ParentAssetId,
Assets.EmployeeId,
Employees.Forename,
Employees.Surname,
Employees.Patronymic FROM Assets INNER JOIN AssetTypes ON Assets.TypeId = AssetTypes.Id
INNER JOIN Employees ON Assets.EmployeeId = Employees.Id;