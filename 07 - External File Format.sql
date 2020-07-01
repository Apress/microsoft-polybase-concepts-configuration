USE [Scratch]
GO
CREATE EXTERNAL FILE FORMAT CsvFileFormat WITH
(
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS
    (
        FIELD_TERMINATOR = N',',
        USE_TYPE_DEFAULT = TRUE,
        STRING_DELIMITER = '"',
        ENCODING = 'UTF8'
    )
);
GO
CREATE EXTERNAL FILE FORMAT ParquetFormat WITH
(
    FORMAT_TYPE = PARQUET,
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'
);
GO
