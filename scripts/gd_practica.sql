USE master
GO

RESTORE FILELISTONLY FROM DISK = N'/scripts/backup/GD2015C1.bak';
GO

RESTORE DATABASE [edgardo_practica_gdd]
FROM DISK = N'/scripts/backup/GD2015C1.bak'
WITH MOVE N'GESTION2009_Data' TO N'/var/opt/mssql/data/mydb_data.mdf',
     MOVE N'GESTION2009_Log' TO N'/var/opt/mssql/data/mydb_log.ldf'
GO