CREATE TRIGGER [dbo].[trg_EmployeePositions_LogChanges]
ON [dbo].[EmployeePositions]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeePositions', i.Id, 'I', NULL, NULL, CONCAT('Added position: ', i.PositionName)
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        IF UPDATE(PositionName)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'EmployeePositions', i.Id, 'U', 'PositionName', d.PositionName, i.PositionName
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.PositionName <> d.PositionName;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeePositions', d.Id, 'D', NULL, CONCAT('Deleted position: ', d.PositionName), NULL
        FROM deleted d;
    END
END;
GO