CREATE TRIGGER [dbo].[trg_VehicleVehicleProperties_LogChanges]
ON [dbo].[VehicleVehicleProperties]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'VehicleVehicleProperties', i.VehicleId, 'I', 'PropertyAssignment', 
               NULL, CONCAT('Added property ', i.PropertyId, ' to vehicle ', i.VehicleId)
        FROM inserted i;
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'VehicleVehicleProperties', d.VehicleId, 'D', 'PropertyAssignment', 
               CONCAT('Removed property ', d.PropertyId, ' from vehicle ', d.VehicleId), NULL
        FROM deleted d;
    END
END;
GO