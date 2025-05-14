-- Триггер для таблицы Transits
GO
CREATE TRIGGER [dbo].[trg_Transits_LogChanges]
ON [dbo].[Transits]
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
            'Transits', 
            i.Id, 
            'I', 
            NULL, 
            NULL, 
            CONCAT('Создан транзит для ТС ID ', i.VehicleId, 
                   ' с грузом ', i.CargoQuantity, 
                   ' с ', i.StartedAt, ' по ', i.EndedAt)
        FROM inserted i;
    END
    
    -- Логирование UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Логируем изменения VehicleId
        IF UPDATE(VehicleId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Transits', 
                i.Id, 
                'U', 
                'VehicleId', 
                CAST(d.VehicleId AS NVARCHAR(50)), 
                CAST(i.VehicleId AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.VehicleId <> d.VehicleId;
        END
        
        -- Логируем изменения CargoQuantity
        IF UPDATE(CargoQuantity)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Transits', 
                i.Id, 
                'U', 
                'CargoQuantity', 
                CAST(d.CargoQuantity AS NVARCHAR(50)), 
                CAST(i.CargoQuantity AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.CargoQuantity <> d.CargoQuantity;
        END
        
        -- Логируем изменения дат
        IF UPDATE(StartedAt) OR UPDATE(EndedAt)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Transits', 
                i.Id, 
                'U', 
                'Dates', 
                CONCAT(d.StartedAt, ' - ', d.EndedAt), 
                CONCAT(i.StartedAt, ' - ', i.EndedAt)
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.StartedAt <> d.StartedAt OR i.EndedAt <> d.EndedAt;
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
            'Transits', 
            d.Id, 
            'D', 
            NULL, 
            CONCAT('Удален транзит для ТС ID ', d.VehicleId, 
                   ' с грузом ', d.CargoQuantity, 
                   ' с ', d.StartedAt, ' по ', d.EndedAt),
            NULL
        FROM deleted d;
    END
END;
GO

-- Триггер для таблицы Employees
GO
CREATE TRIGGER [dbo].[trg_Employees_LogChanges]
ON [dbo].[Employees]
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
            'Employees', 
            i.Id, 
            'I', 
            NULL, 
            NULL, 
            CONCAT('Добавлен сотрудник: ', i.Surname, ' ', i.Forename, ' ', i.Patronymic)
        FROM inserted i;
    END
    
    -- Логирование UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Логируем изменения ФИО
        IF UPDATE(Forename) OR UPDATE(Surname) OR UPDATE(Patronymic)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Employees', 
                i.Id, 
                'U', 
                'FullName', 
                CONCAT(d.Surname, ' ', d.Forename, ' ', d.Patronymic), 
                CONCAT(i.Surname, ' ', i.Forename, ' ', i.Patronymic)
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.Surname <> d.Surname OR i.Forename <> d.Forename OR i.Patronymic <> d.Patronymic;
        END
        
        -- Логируем изменения PositionId
        IF UPDATE(PositionId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Employees', 
                i.Id, 
                'U', 
                'PositionId', 
                CAST(d.PositionId AS NVARCHAR(50)), 
                CAST(i.PositionId AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.PositionId <> d.PositionId;
        END
        
        -- Логируем изменения ManagerId
        IF UPDATE(ManagerId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Employees', 
                i.Id, 
                'U', 
                'ManagerId', 
                ISNULL(CAST(d.ManagerId AS NVARCHAR(50)), 'NULL'), 
                ISNULL(CAST(i.ManagerId AS NVARCHAR(50)), 'NULL')
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE ISNULL(i.ManagerId, 0) <> ISNULL(d.ManagerId, 0);
        END
        
        -- Логируем изменения BrigadeId
        IF UPDATE(BrigadeId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Employees', 
                i.Id, 
                'U', 
                'BrigadeId', 
                ISNULL(CAST(d.BrigadeId AS NVARCHAR(50)), 'NULL'), 
                ISNULL(CAST(i.BrigadeId AS NVARCHAR(50)), 'NULL')
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE ISNULL(i.BrigadeId, 0) <> ISNULL(d.BrigadeId, 0);
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
            'Employees', 
            d.Id, 
            'D', 
            NULL, 
            CONCAT('Удален сотрудник: ', d.Surname, ' ', d.Forename, ' ', d.Patronymic),
            NULL
        FROM deleted d;
    END
END;
GO

-- Триггер для таблицы Brigades
GO
CREATE TRIGGER [dbo].[trg_Brigades_LogChanges]
ON [dbo].[Brigades]
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
            'Brigades', 
            i.Id, 
            'I', 
            NULL, 
            NULL, 
            'Создана новая бригада'
        FROM inserted i;
    END
    
    -- Логирование UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- Логируем изменения бригадира
        IF UPDATE(EmployeeId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Brigades', 
                i.Id, 
                'U', 
                'EmployeeId', 
                ISNULL(CAST(d.EmployeeId AS NVARCHAR(50)), 'NULL'), 
                ISNULL(CAST(i.EmployeeId AS NVARCHAR(50)), 'NULL')
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE ISNULL(i.EmployeeId, 0) <> ISNULL(d.EmployeeId, 0);
        END
        
        -- Логируем изменения актива
        IF UPDATE(AssetId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Brigades', 
                i.Id, 
                'U', 
                'AssetId', 
                ISNULL(CAST(d.AssetId AS NVARCHAR(50)), 'NULL'), 
                ISNULL(CAST(i.AssetId AS NVARCHAR(50)), 'NULL')
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE ISNULL(i.AssetId, 0) <> ISNULL(d.AssetId, 0);
        END
        
        -- Логируем изменения даты формирования
        IF UPDATE(FormedAt)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Brigades', 
                i.Id, 
                'U', 
                'FormedAt', 
                CONVERT(NVARCHAR(50), d.FormedAt, 121), 
                CONVERT(NVARCHAR(50), i.FormedAt, 121)
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.FormedAt <> d.FormedAt;
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
            'Brigades', 
            d.Id, 
            'D', 
            NULL, 
            'Удалена бригада',
            NULL
        FROM deleted d;
    END
END;
GO

-- Триггер для таблицы Assets
GO
CREATE TRIGGER [dbo].[trg_Assets_LogChanges]
ON [dbo].[Assets]
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
            'Assets', 
            i.Id, 
            'I', 
            NULL, 
            NULL, 
            CONCAT('Добавлен актив: ', i.Address, ' (тип: ', i.TypeId, ')')
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
                'Assets', 
                i.Id, 
                'U', 
                'TypeId', 
                CAST(d.TypeId AS NVARCHAR(50)), 
                CAST(i.TypeId AS NVARCHAR(50))
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.TypeId <> d.TypeId;
        END
        
        -- Логируем изменения EmployeeId
        IF UPDATE(EmployeeId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Assets', 
                i.Id, 
                'U', 
                'EmployeeId', 
                ISNULL(CAST(d.EmployeeId AS NVARCHAR(50)), 'NULL'), 
                ISNULL(CAST(i.EmployeeId AS NVARCHAR(50)), 'NULL')
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE ISNULL(i.EmployeeId, 0) <> ISNULL(d.EmployeeId, 0);
        END
        
        -- Логируем изменения ParentAssetId
        IF UPDATE(ParentAssetId)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Assets', 
                i.Id, 
                'U', 
                'ParentAssetId', 
                ISNULL(CAST(d.ParentAssetId AS NVARCHAR(50)), 'NULL'), 
                ISNULL(CAST(i.ParentAssetId AS NVARCHAR(50)), 'NULL')
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE ISNULL(i.ParentAssetId, 0) <> ISNULL(d.ParentAssetId, 0);
        END
        
        -- Логируем изменения Address
        IF UPDATE(Address)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'Assets', 
                i.Id, 
                'U', 
                'Address', 
                d.Address, 
                i.Address
            FROM inserted i
            JOIN deleted d ON i.Id = d.Id
            WHERE i.Address <> d.Address;
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
            'Assets', 
            d.Id, 
            'D', 
            NULL, 
            CONCAT('Удален актив: ', d.Address, ' (тип: ', d.TypeId, ')'),
            NULL
        FROM deleted d;
    END
END;
GO