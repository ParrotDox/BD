CREATE TRIGGER [dbo].[trg_TechServiceParts_LogChanges]
ON [dbo].[TechServiceParts]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Логирование INSERT (добавление новой связи запчасти с ТО)
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] (
            [TableName], [RecordId], [OperationType], [ColumnName], 
            [OldValue], [NewValue]
        )
        SELECT 
            'TechServiceParts', 
            i.Id, 
            'I', 
            NULL, 
            NULL, 
            CONCAT('Added part ', i.PartId, ' to tech service ', i.TechServiceId)
        FROM inserted i;
    END
    
    -- Логирование UPDATE (изменение связи - обычно не должно происходить)
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Логируем изменение TechServiceId
        IF UPDATE(TechServiceId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'TechServiceParts', 
                i.Id, 
                'U', 
                'TechServiceId', 
                CAST(d.TechServiceId AS NVARCHAR(50)), 
                CAST(i.TechServiceId AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.TechServiceId <> d.TechServiceId;
        END
        
        -- Логируем изменение PartId
        IF UPDATE(PartId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'TechServiceParts', 
                i.Id, 
                'U', 
                'PartId', 
                CAST(d.PartId AS NVARCHAR(50)), 
                CAST(i.PartId AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.PartId <> d.PartId;
        END
    END
    
    -- Логирование DELETE (удаление связи запчасти с ТО)
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] (
            [TableName], [RecordId], [OperationType], [ColumnName], 
            [OldValue], [NewValue]
        )
        SELECT 
            'TechServiceParts', 
            d.Id, 
            'D', 
            NULL, 
            CONCAT('Removed part ', d.PartId, ' from tech service ', d.TechServiceId), 
            NULL
        FROM deleted d;
    END
END;
GO