CREATE TRIGGER [dbo].[trg_EmployeesEmployeeProperties_LogChanges]
ON [dbo].[EmployeesEmployeeProperties]
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    
    -- INSERT
    IF EXISTS (SELECT * FROM inserted) AND NOT EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeesEmployeeProperties', i.EmployeeId, 'I', 'PropertyAssignment', 
               NULL, CONCAT('Added property ', i.PropertyId, ' to employee ', i.EmployeeId, ' with value: ', i.Val)
        FROM inserted i;
    END
    
    -- UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        IF UPDATE(Val)
        BEGIN
            INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
            SELECT 'EmployeesEmployeeProperties', i.EmployeeId, 'U', 'PropertyValue', 
                   d.Val, i.Val
            FROM inserted i JOIN deleted d ON i.EmployeeId = d.EmployeeId AND i.PropertyId = d.PropertyId
            WHERE i.Val <> d.Val;
        END
    END
    
    -- DELETE
    IF NOT EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        INSERT INTO [dbo].[ChangeLogs] ([TableName], [RecordId], [OperationType], [ColumnName], [OldValue], [NewValue])
        SELECT 'EmployeesEmployeeProperties', d.EmployeeId, 'D', 'PropertyAssignment', 
               CONCAT('Removed property ', d.PropertyId, ' from employee ', d.EmployeeId, ' (value was: ', d.Val, ')'), NULL
        FROM deleted d;
    END
END;
GO