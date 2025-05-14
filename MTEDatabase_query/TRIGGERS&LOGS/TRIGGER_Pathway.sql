CREATE TRIGGER [dbo].[trg_PathWay_LogChanges]
ON [dbo].[PathWay]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'PathWay', i.Id, 'I', NULL, NULL, 
               CONCAT('Added pathway: ', i.StartLocation, ' to ', i.EndLocation, ' (Length: ', i.LengthOfPathWay, ')')
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- TypeId
        IF UPDATE(TypeId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'PathWay', i.Id, 'U', 'TypeId', CAST(d.TypeId AS NVARCHAR(50)), CAST(i.TypeId AS NVARCHAR(50))
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.TypeId <> d.TypeId;
        END
        
        -- LengthOfPathWay
        IF UPDATE(LengthOfPathWay)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'PathWay', i.Id, 'U', 'LengthOfPathWay', 
                   CAST(d.LengthOfPathWay AS NVARCHAR(50)), CAST(i.LengthOfPathWay AS NVARCHAR(50))
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.LengthOfPathWay <> d.LengthOfPathWay;
        END
        
        -- Locations
        IF UPDATE(StartLocation) OR UPDATE(EndLocation)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'PathWay', i.Id, 'U', 'Route', 
                   CONCAT(d.StartLocation, ' to ', d.EndLocation),
                   CONCAT(i.StartLocation, ' to ', i.EndLocation)
            FROM inserted i JOIN deleted d ON i.Id = d.Id
            WHERE i.StartLocation <> d.StartLocation OR i.EndLocation <> d.EndLocation;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'PathWay', d.Id, 'D', NULL, 
               CONCAT('Deleted pathway: ', d.StartLocation, ' to ', d.EndLocation, ' (Length: ', d.LengthOfPathWay, ')'), NULL
        FROM deleted d;
    END
END;
GO