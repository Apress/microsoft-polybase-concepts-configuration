USE [Scratch]
GO
OPEN MASTER KEY DECRYPTION BY PASSWORD = '<<SomeSecureKey>>';
GO
SELECT TOP(10)
    *
FROM dbo.NorthCarolinaPopulation;
GO
SELECT TOP(10)
    *
FROM dbo.NorthCarolinaPopulation
WHERE
    Name = 'Durham city';
GO
SELECT TOP(10)
    *
FROM dbo.NorthCarolinaPopulation
WHERE
    Name = 'Durham city'
    AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP');
GO
SELECT TOP(10)
    *
FROM dbo.NorthCarolinaPopulation
WHERE
    Name = 'Durham city'
    AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP')
ORDER BY
    Year DESC;
GO
SELECT
    AVG(Population) AS AvgPopulation
FROM dbo.NorthCarolinaPopulation
WHERE
    Name = 'Durham city'
    AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP');
GO
SELECT
    AVG(Population) AS AvgPopulation,
    MAX(Year) AS MaxYear
FROM dbo.NorthCarolinaPopulation
WHERE
    Name = 'Durham city'
    AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP');
GO
SELECT
    Name,
    AVG(Population) AS AvgPopulation,
    MAX(Year) AS MaxYear
FROM dbo.NorthCarolinaPopulation
WHERE
    Name LIKE '% city'
    AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP')
GROUP BY
    Name
ORDER BY
    Name;
GO
SELECT
    Name,
    AVG(Population) AS AvgPopulation,
    MAX(Year) AS MaxYear
FROM dbo.NorthCarolinaPopulation
WHERE
    Name LIKE '% city'
    AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP')
GROUP BY
    Name
HAVING
    AVG(Population) > 100000
ORDER BY
    Name;
GO
WITH records AS
(
    SELECT
        Name,
        AVG(Population) AS AvgPopulation,
        MAX(Year) AS MaxYear
    FROM dbo.NorthCarolinaPopulation
    WHERE
        Name LIKE '% city'
        AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP')
        AND IsPrimaryGeography = 1
    GROUP BY
        Name
)
SELECT *
FROM records
WHERE AVG(Population) > 100000
ORDER BY
    Name;
GO
WITH records AS
(
    SELECT
        Name,
        AVG(Population) AS AvgPopulation,
        MAX(Year) AS MaxYear
    FROM dbo.NorthCarolinaPopulation
    WHERE
        Name LIKE '% city'
        AND PopulationType IN ('POPESTIMATE', 'CENSUSPOP')
        AND IsPrimaryGeography = 1
    GROUP BY
        Name
)
SELECT *
FROM records
    CROSS APPLY
    (
        SELECT *
        FROM dbo.NorthCarolinaPopulation ncp
        WHERE
            ncp.Name = r.Name
            AND ncp.Population = r.AvgPopulation
            AND ncp.IsPrimaryGeography = 1
    ) p
WHERE
    r.AvgPopulation > 10000
ORDER BY
    p.Name;
GO
