CREATE TABLE [dbo].[ChangeLogs] (
    [Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [TableName] NVARCHAR(128) NOT NULL,          -- Название таблицы, где произошли изменения
    [RecordId] INT NOT NULL,                     -- ID изменяемой записи
    [OperationType] CHAR(1) NOT NULL,            -- Тип операции: I=Insert, U=Update, D=Delete
    [ColumnName] NVARCHAR(128) NULL,             -- Название изменяемого столбца (для UPDATE)
    [OldValue] NVARCHAR(MAX) NULL,               -- Старое значение
    [NewValue] NVARCHAR(MAX) NULL,               -- Новое значение
    [ChangeDate] DATETIME2 NOT NULL DEFAULT SYSDATETIME(), -- Дата и время изменения
);