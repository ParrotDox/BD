CREATE TRIGGER [dbo].[trg_Vehicles_LogChanges]
ON [dbo].[Vehicles]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- Логирование INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] (
            [TableName], [RecordId], [OperationType], [ColumnName], 
            [OldValue], [NewValue]
        )
        SELECT 
            'Vehicles', 
            i.Id, 
            'I', 
            NULL, 
            NULL, 
            CONCAT('Добавлен транспорт: ', i.VehicleMake, ' ', i.VehicleModel, 
                  ' (Гос.номер: ', i.LicensePlate, ')')
        FROM inserted i;
    END
    
    -- Логирование UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Логируем изменения TypeId
        IF UPDATE(TypeId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Vehicles', 
                i.Id, 
                'U', 
                'TypeId', 
                CAST(d.TypeId AS NVARCHAR(50)), 
                CAST(i.TypeId AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.TypeId <> d.TypeId;
        END
        
        -- Логируем изменения StatusId
        IF UPDATE(StatusId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Vehicles', 
                i.Id, 
                'U', 
                'StatusId', 
                CAST(d.StatusId AS NVARCHAR(50)), 
                CAST(i.StatusId AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.StatusId <> d.StatusId;
        END
        
        -- Логируем изменения LicensePlate
        IF UPDATE(LicensePlate)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Vehicles', 
                i.Id, 
                'U', 
                'LicensePlate', 
                d.LicensePlate, 
                i.LicensePlate
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.LicensePlate <> d.LicensePlate;
        END
        
        -- Логируем изменения VehicleMake и VehicleModel
        IF UPDATE(VehicleMake) OR UPDATE(VehicleModel)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Vehicles', 
                i.Id, 
                'U', 
                'VehicleInfo', 
                CONCAT(d.VehicleMake, ' ', d.VehicleModel), 
                CONCAT(i.VehicleMake, ' ', i.VehicleModel)
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.VehicleMake <> d.VehicleMake OR i.VehicleModel <> d.VehicleModel;
        END
        
        -- Логируем изменения Capacity
        IF UPDATE(Capacity)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Vehicles', 
                i.Id, 
                'U', 
                'Capacity', 
                CAST(d.Capacity AS NVARCHAR(50)), 
                CAST(i.Capacity AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.Capacity <> d.Capacity;
        END
        
        -- Логируем изменения WriteOffAt
        IF UPDATE(WriteOffAt)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Vehicles', 
                i.Id, 
                'U', 
                'WriteOffAt', 
                ISNULL(CONVERT(NVARCHAR(50), d.WriteOffAt, 120), 'NULL'), 
                ISNULL(CONVERT(NVARCHAR(50), i.WriteOffAt, 120), 'NULL')
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE ISNULL(i.WriteOffAt, '') <> ISNULL(d.WriteOffAt, '');
        END
    END
    
    -- Логирование DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] (
            [TableName], [RecordId], [OperationType], [ColumnName], 
            [OldValue], [NewValue]
        )
        SELECT 
            'Vehicles', 
            d.Id, 
            'D', 
            NULL, 
            CONCAT('Удален транспорт: ', d.VehicleMake, ' ', d.VehicleModel, 
                  ' (Гос.номер: ', d.LicensePlate, ')'),
            NULL
        FROM deleted d;
    END
END;