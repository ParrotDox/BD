CREATE TRIGGER [dbo].[trg_EmployeeProperties_LogChanges]
ON [dbo].[EmployeeProperties]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeeProperties', i.Id, 'I', NULL, NULL, CONCAT('Added employee property: ', i.PropertyName)
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        IF UPDATE(PropertyName)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'EmployeeProperties', i.Id, 'U', 'PropertyName', d.PropertyName, i.PropertyName
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.PropertyName <> d.PropertyName;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeeProperties', d.Id, 'D', NULL, CONCAT('Deleted employee property: ', d.PropertyName), NULL
        FROM deleted d;
    END
END;
GO