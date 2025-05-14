CREATE TRIGGER [dbo].[trg_VehicleVehicleProperties_LogChanges]
ON [dbo].[VehicleVehicleProperties]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- ����������� INSERT (���������� ����� ����� �������� � ������������ ���������)
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] (
            [TableName], [RecordId], [OperationType], [ColumnName], 
            [OldValue], [NewValue]
        )
        SELECT 
            'VehicleVehicleProperties', 
            i.VehicleId, 
            'I', 
            'PropertyAssignment', 
            NULL, 
            CONCAT('Added property ', i.PropertyId, ' to vehicle ', i.VehicleId, 
                  ' with value: ', i.Val)
        FROM inserted i;
    END
    
    -- ����������� UPDATE (��������� �������� ��������)
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        -- �������� ������ ���� ���������� �������� Val
        IF UPDATE(Val)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] (
                [TableName], [RecordId], [OperationType], [ColumnName], 
                [OldValue], [NewValue]
            )
            SELECT 
                'VehicleVehicleProperties', 
                i.VehicleId, 
                'U', 
                'PropertyValue', 
                CONCAT('Property ', d.PropertyId, ' old value: ', d.Val), 
                CONCAT('Property ', i.PropertyId, ' new value: ', i.Val)
            FROM inserted i
            JOIN deleted d ON i.VehicleId = d.VehicleId AND i.PropertyId = d.PropertyId
            WHERE i.Val <> d.Val;
        END
    END
    
    -- ����������� DELETE (�������� ����� �������� � ������������ ���������)
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] (
            [TableName], [RecordId], [OperationType], [ColumnName], 
            [OldValue], [NewValue]
        )
        SELECT 
            'VehicleVehicleProperties', 
            d.VehicleId, 
            'D', 
            'PropertyAssignment', 
            CONCAT('Removed property ', d.PropertyId, ' from vehicle ', d.VehicleId, 
                  ' (value was: ', d.Val, ')'), 
            NULL
        FROM deleted d;
    END
END;
GO