/*formating and sorting data*/
/*formating*/

proc print data=pg1.storm_summary(obs=20);
	format Lat Lon 4. StartDate EndDate date11.;
run;

proc freq data=pg1.storm_summary order=freq;
	tables StartDate;
	format StartDate MONNAME.;
run;

/*sorting*/

proc sort data=pg1.storm_summary out=storm_sort;
    where Basin = "NA";
	by descending MaxWindMPH ;
run;

*get rid of all duplicates;

proc sort data=pg1.np_largeparks out=park_clean nodupkey dupout=park_dups;
          by _all_;
run;
