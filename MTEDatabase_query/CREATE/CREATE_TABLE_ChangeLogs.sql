CREATE TABLE [dbo].[ChangeLogs] (
    [Id] INT IDENTITY(1,1) PRIMARY KEY NOT NULL,
    [TableName] NVARCHAR(128) NOT NULL,          -- �������� �������, ��� ��������� ���������
    [RecordId] INT NOT NULL,                     -- ID ���������� ������
    [OperationType] CHAR(1) NOT NULL,            -- ��� ��������: I=Insert, U=Update, D=Delete
    [ColumnName] NVARCHAR(128) NULL,             -- �������� ����������� ������� (��� UPDATE)
    [OldValue] NVARCHAR(MAX) NULL,               -- ������ ��������
    [NewValue] NVARCHAR(MAX) NULL,               -- ����� ��������
    [ChangeDate] DATETIME2 NOT NULL DEFAULT SYSDATETIME(), -- ���� � ����� ���������
);