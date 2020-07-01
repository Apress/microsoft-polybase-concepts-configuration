USE [Scratch]
GO
OPEN MASTER KEY DECRYPTION BY PASSWORD = '<<SomeSecureKey>>';
GO
-- Make sure to update these with your Cosmos username
-- and either the primary or secondary password.
CREATE DATABASE SCOPED CREDENTIAL CosmosCredential
WITH IDENTITY = '<Your User>', SECRET = '<Your PWD>';
GO
CREATE EXTERNAL DATA SOURCE CosmosDB WITH
(
    LOCATION = 'mongodb://<youraccount>.documents.azure.com:10255',
    CONNECTION_OPTIONS = 'ssl=true',
    CREDENTIAL = CosmosCredential,
    PUSHDOWN = ON
);
GO

-- Make sure to update these with your Azure Blob Storage account and connection key.
CREATE DATABASE SCOPED CREDENTIAL AzureStorageCredential
WITH IDENTITY = '<Your Account>', SECRET = '<Your Connection Key>';
GO
CREATE EXTERNAL DATA SOURCE AzureNCPopBlob WITH
(
    TYPE = HADOOP,
    LOCATION = 'wasbs://<your_container>@<your_account>.blob.core.windows.net',
    CREDENTIAL = AzureStorageCredential
);
GO

CREATE EXTERNAL DATA SOURCE HadoopCluster WITH
(
    TYPE = HADOOP,
    LOCATION = 'hdfs://<your_name_node>:8020',
    RESOURCE_MANAGER_LOCATION = N'<your_name_node>:8050'
);
GO

SELECT * FROM sys.external_data_sources;
GO
