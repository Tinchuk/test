use master
go

-- drop and create database Nova_Poshta
drop database if exists Nova_Poshta
go
create database Nova_Poshta
on
(name = Nova_Poshta_data,
 filename = N'C:\Program Files\Microsoft SQL Server\MSSQL14.NAZARSSQL\MSSQL\DATA\Nova_Poshta_data.mdf', 
 size = 10MB,   
 filegrowth = 10%)
log on
(name = Nova_Poshta_log,
 filename = N'C:\Program Files\Microsoft SQL Server\MSSQL14.NAZARSSQL\MSSQL\DATA\Nova_Poshta_log.ldf',
 size = 5MB,
 filegrowth = 20%)
go

