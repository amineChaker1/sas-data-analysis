/*Character Functions*/

*character cleaning functions;
data weather_japan_clean;
    set pg2.weather_japan;
    NewLocation= COMPBL(Location);
    NewStation= COMPRESS(Station, "-") ;
run;

*exctracting words from strings;
data weather_japan_clean;
	set pg2.weather_japan;
	Location=compbl(Location);
	City=propcase(scan(Location, 1, ','), ' ');
	Prefecture=strip(scan(Location, 2, ',')) ;
	putlog Prefecture $quote20.;
	*if Prefecture="Tokyo";
run;

*searching for specific words in a string;
data storm_damage2;
	set pg2.storm_damage;
	drop Date Cost;
	CategoryLoc=find(Summary, 'category' , "I");
	if CategoryLoc > 0 then Category=substr(Summary,CategoryLoc, 10);
run;

proc print data=storm_damage2;
	var Event Summary Cat:;
run;

*concatenating strings;
data storm_id;
	set pg2.storm_final;
	keep StormID: ;
	Day=StartDate-intnx('year', StartDate, 0);
	StormID1=cat(Name, Season, Day);
	StormID2=cats(Name,"-", Season, Day);
	StormID3=catx("-",Name, Season, Day);
run;


