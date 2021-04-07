DROP TABLE max_death;

CREATE EXTERNAL TABLE max_death(
Country STRING,
Continent STRING,
Population INT,
TotalCases INT,
TotalDeaths INT,
TotalRecovered INT,
ActiveCases INT,
Critical INT,
TotalTests INT
)

COMMENT 'max death'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

INSERT INTO max_death SELECT * FROM default.data WHERE TotalDeaths = (SELECT MAX(TotalDeaths) FROM default.data);
