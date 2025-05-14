CREATE TRIGGER [dbo].[trg_VehicleProperties_LogChanges]
ON [dbo].[VehicleProperties]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'VehicleProperties', i.Id, 'I', NULL, NULL, CONCAT('Added property: ', i.PropertyName)
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        IF UPDATE(PropertyName)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'VehicleProperties', i.Id, 'U', 'PropertyName', d.PropertyName, i.PropertyName
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.PropertyName <> d.PropertyName;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'VehicleProperties', d.Id, 'D', NULL, CONCAT('Deleted property: ', d.PropertyName), NULL
        FROM deleted d;
    END
END;
GO