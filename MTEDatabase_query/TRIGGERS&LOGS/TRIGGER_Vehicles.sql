CREATE TRIGGER [dbo].[trg_Vehicles_LogChanges]
ON [dbo].[Vehicles]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- ����������� INSERT
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
            CONCAT('�������� ���������: ', i.VehicleMake, ' ', i.VehicleModel, 
                  ' (���.�����: ', i.LicensePlate, ')')
        FROM inserted i;
    END
    
    -- ����������� UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- �������� ��������� TypeId
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
        
        -- �������� ��������� StatusId
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
        
        -- �������� ��������� LicensePlate
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
        
        -- �������� ��������� VehicleMake � VehicleModel
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
        
        -- �������� ��������� Capacity
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
        
        -- �������� ��������� WriteOffAt
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
    
    -- ����������� DELETE
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
            CONCAT('������ ���������: ', d.VehicleMake, ' ', d.VehicleModel, 
                  ' (���.�����: ', d.LicensePlate, ')'),
            NULL
        FROM deleted d;
    END
END;