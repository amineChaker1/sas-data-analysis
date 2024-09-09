/*exporting sas table as a csv */
*using a macro variable;
proc export data=pg1.storm_final outfile="&outpath/storm_final.csv" dbms=csv replace ;
run; 

/*exporting sas table as a excel */

libname xlout xlsx "&outpath/southPacific.xlsx";
data xlout.South_Pacific;
	set pg1.storm_final;
	where Basin="SP";
run;

proc means data=pg1.storm_final noprint maxdec=1;
	where Basin="SP";
	var MaxWindKM;
	class Season;
	ways 1;
	output out=xlout.Season_Stats n=Count mean=AvgMaxWindKM max=StrongestWindKM;
run;
libname xlout clear;