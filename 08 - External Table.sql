USE [Scratch]
GO
OPEN MASTER KEY DECRYPTION BY PASSWORD = '<<SomeSecureKey>>';
GO
-- Run the program in "08 - External Table\CosmosMongo.zip" to
-- populate a PolyBaseTest.Volcano table in Cosmos DB.
CREATE EXTERNAL TABLE dbo.Volcano
(
    _id NVARCHAR(100) NOT NULL, 
    VolcanoName NVARCHAR(100) NOT NULL, 
    Country NVARCHAR(100) NULL, 
    Region NVARCHAR(100) NULL,
    Location_Type NVARCHAR(100) NULL,
    Elevation INT NULL,
    Type NVARCHAR(100) NULL,
    Status NVARCHAR(200) NULL,
    LastEruption NVARCHAR(300) NULL
)
WITH
(
    DATA_SOURCE = CosmosDB,
    LOCATION='PolyBaseTest.Volcano'
);
GO

-- Copy the "08 - External Table\NorthCarolinaPopulation.csv" file
-- into your Blob Storage container, putting it into a folder named Census.
-- Then run this script.
CREATE EXTERNAL TABLE dbo.NorthCarolinaPopulation
(
    SumLev INT NOT NULL,
    County INT NOT NULL,
    Place INT NOT NULL,
    IsPrimaryGeography BIT NOT NULL,
    [Name] VARCHAR(120) NOT NULL,
    PopulationType VARCHAR(20) NOT NULL,
    Year INT NOT NULL,
    Population INT NOT NULL
)
WITH
(
    DATA_SOURCE = AzureNCPopBlob,
    LOCATION = N'Census/NorthCarolinaPopulation.csv',
    FILE_FORMAT = CsvFileFormat,
    REJECT_TYPE = VALUE,
    REJECT_VALUE = 5
);
GO

SELECT * FROM dbo.Volcano;
GO
SELECT * FROM dbo.NorthCarolinaPopulation;
GO
