CREATE TRIGGER [dbo].[trg_Parts_LogChanges]
ON [dbo].[Parts]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'Parts', i.Id, 'I', NULL, NULL, CONCAT('Added part: ', i.PartName, ' (Price: ', i.Price, ')')
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- PartName
        IF UPDATE(PartName)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'Parts', i.Id, 'U', 'PartName', d.PartName, i.PartName
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.PartName <> d.PartName;
        END
        
        -- Price
        IF UPDATE(Price)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'Parts', i.Id, 'U', 'Price', CAST(d.Price AS NVARCHAR(50)), CAST(i.Price AS NVARCHAR(50))
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.Price <> d.Price;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'Parts', d.Id, 'D', NULL, CONCAT('Deleted part: ', d.PartName, ' (Price: ', d.Price, ')'), NULL
        FROM deleted d;
    END
END;
GO