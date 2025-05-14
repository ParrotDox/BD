CREATE TRIGGER [dbo].[trg_TechServices_LogChanges]
ON [dbo].[TechServices]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'TechServices', i.Id, 'I', NULL, NULL, 
               CONCAT('Tech service for vehicle ', i.VehicleId, ' by employee ', i.EmployeeId, 
                      ' at ', CONVERT(NVARCHAR, i.CarriedAt, 120), ' (Mileage: ', i.Mileage, ')')
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Mileage
        IF UPDATE(Mileage)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'TechServices', i.Id, 'U', 'Mileage', 
                   CAST(d.Mileage AS NVARCHAR(50)), CAST(i.Mileage AS NVARCHAR(50))
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.Mileage <> d.Mileage;
        END
        
        -- CarriedAt
        IF UPDATE(CarriedAt)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'TechServices', i.Id, 'U', 'CarriedAt', 
                   CONVERT(NVARCHAR, d.CarriedAt, 120), CONVERT(NVARCHAR, i.CarriedAt, 120)
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.CarriedAt <> d.CarriedAt;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'TechServices', d.Id, 'D', NULL, 
               CONCAT('Deleted tech service for vehicle ', d.VehicleId, ' by employee ', d.EmployeeId, 
                      ' at ', CONVERT(NVARCHAR, d.CarriedAt, 120), ' (Mileage: ', d.Mileage, ')'), NULL
        FROM deleted d;
    END
END;
GO