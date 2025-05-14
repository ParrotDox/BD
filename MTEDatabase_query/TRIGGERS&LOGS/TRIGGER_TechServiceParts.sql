CREATE TRIGGER [dbo].[trg_TechServiceParts_LogChanges]
ON [dbo].[TechServiceParts]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- ����������� INSERT (���������� ����� ����� �������� � ��)
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
    
    -- ����������� UPDATE (��������� ����� - ������ �� ������ �����������)
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- �������� ��������� TechServiceId
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
        
        -- �������� ��������� PartId
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
    
    -- ����������� DELETE (�������� ����� �������� � ��)
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