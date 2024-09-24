/*Merging Tables*/

proc sort data=pg2.class_teachers out=teachers_sort;
	by Name;
run;

proc sort data=pg2.class_test2 out=test2_sort;
	by Name;
run;

data class2;
	merge teachers_sort test2_sort;
	by Name;
run;

/*merging with non matching names*/

proc sort data=pg2.storm_final out=storm_final_sort;
	by Season Name;
run;

data storm_damage;
	set pg2.storm_damage;
	Season=Year(date);
	Name=upcase(scan(Event, -1));
	format Date date9. Cost dollar16.;
	drop event;
run;

proc sort data=storm_damage;
	by Season Name;
run;

data damage_detail storm_other(drop=Cost) ;
	merge storm_final_sort(in=inFinal) storm_damage(in=inDamage);
	keep Season Name BasinName MaxWindMPH MinPressure Cost;
	by Season Name;
	if inDamage=1 and inFinal=1 then output damage_detail;
	else output storm_other;
run;

/*Other test with non matching cols*/

proc sort data=pg2.np_codelookup out=codelookup;
    by ParkCode;
run;

proc sort data=pg2.np_2016 out=tb2016;
    by ParkCode;
run;

data work.parkStats(keep=ParkCode ParkName Year Month DayVisits) work.parkOther(keep=ParkCode ParkName) ;
    merge codelookup tb2016(in=in2016) ;
    by ParkCode;
    if in2016=1 then output work.parkStats;
    else output work.parkOther;
run;
    
proc sort data=pg
