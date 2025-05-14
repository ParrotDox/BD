CREATE VIEW V_Pathways AS
SELECT PathWay.Id,
PathWay.StartLocation,
PathWay.EndLocation,
PathWay.LengthOfPathWay,
PathWayTypes.TypeName
FROM PathWay INNER JOIN PathWayTypes ON PathWay.TypeId = PathWayTypes.Id;