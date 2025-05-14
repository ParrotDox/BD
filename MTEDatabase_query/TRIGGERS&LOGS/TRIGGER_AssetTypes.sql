CREATE TRIGGER [dbo].[trg_AssetTypes_LogChanges]
ON [dbo].[AssetTypes]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'AssetTypes', i.Id, 'I', NULL, NULL, CONCAT('Added asset type: ', i.TypeName)
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        IF UPDATE(TypeName)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'AssetTypes', i.Id, 'U', 'TypeName', d.TypeName, i.TypeName
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.TypeName <> d.TypeName;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'AssetTypes', d.Id, 'D', NULL, CONCAT('Deleted asset type: ', d.TypeName), NULL
        FROM deleted d;
    END
END;
GO