CREATE TRIGGER [dbo].[trg_EmployeeVehicles_LogChanges]
ON [dbo].[EmployeeVehicles]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeeVehicles', i.EmployeeId, 'I', 'VehicleAssignment', 
               NULL, CONCAT('Assigned vehicle ', i.VehicleId, ' to employee ', i.EmployeeId)
        FROM inserted i;
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeeVehicles', d.EmployeeId, 'D', 'VehicleAssignment', 
               CONCAT('Unassigned vehicle ', d.VehicleId, ' from employee ', d.EmployeeId), NULL
        FROM deleted d;
    END
END;
GO