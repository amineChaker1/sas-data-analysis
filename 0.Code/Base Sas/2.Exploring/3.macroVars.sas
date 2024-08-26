/*macro variables*/

%LET maxWind = 156;
%LET basinChar = NA;
%LET dateStart = 01JAN2000;
proc print data=pg1.storm_summary;
	where MaxWindMPH>=&maxWind and Basin="&basinChar" and StartDate>="&dateStart"d;
	var Basin Name StartDate EndDate MaxWindMPH;
run;

proc means data=pg1.storm_summary;
	where MaxWindMPH>=&maxWind and Basin="&basinChar" and StartDate>="&dateStart"d;
	var MaxWindMPH MinPressure;
run; 

/*using % after the variable name*/
%LET ParkCode = ZION;
%LET SpeciesCat = Bird;

proc freq data=pg1.np_species;
     tables Abundance Conservation_Status;
     where Species_ID like "&ParkCode%" and Category = "&SpeciesCat";
run;
