-- Enable PolyBase.
-- Ensure that TCP/IP is already enabled.
USE [master]
GO
EXEC sp_configure 'polybase enabled', 1;
GO
RECONFIGURE
GO
-- Then restart the SQL Server service as well as the PolyBase Engine
-- and Data Movement Service.

USE [master]
GO
CREATE DATABASE Scratch
GO

USE [Scratch]
GO
-- You probably want to use a better encryption key.  Just make sure to update
-- it in all of the scripts!
CREATE MASTER KEY ENCRYPTION BY PASSWORD = '<<SomeSecureKey>>';
GO
