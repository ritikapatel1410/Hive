DROP TABLE india_data;

CREATE EXTERNAL TABLE india_data(
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

COMMENT 'india data'
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
STORED AS TEXTFILE;

INSERT INTO india_data SELECT * FROM default.data where country='India';
