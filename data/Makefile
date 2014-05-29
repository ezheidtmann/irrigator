
.PHONY: all clean
all: US1ORMT0033.PRCP.csv ghcnd-stations.txt Makefile

clean: 
	rm US1ORMT0033.PRCP.csv

US1ORMT0033.PRCP.csv: 2011.csv.gz 2012.csv.gz 2013.csv.gz
	zcat 2011.csv.gz 2012.csv.gz 2013.csv.gz | grep '^US1ORMT0033.*PRCP' > US1ORMT0033.PRCP.csv

2011.csv.gz:
	wget -c ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/2011.csv.gz
2012.csv.gz:
	wget -c ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/2012.csv.gz
2013.csv.gz:
	wget -c ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/by_year/2013.csv.gz

grid.prcp.DMean:
	wget -c http://www1.ncdc.noaa.gov/pub/data/ghcn/v2/grid/grid.prcp.DMean

ghcnd-stations.txt:
	wget -c ftp://ftp.ncdc.noaa.gov/pub/data/ghcn/daily/ghcnd-stations.txt
