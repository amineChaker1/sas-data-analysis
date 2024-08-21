/*Understanding Data Step Processing*/
*underlying the importance of statment placements in the data step;
data storm_complete;
	set pg2.storm_summary_small; 
	where Name is not missing;
	Basin=upcase(Basin);
	StormLength=EndDate-StartDate;
	if substr(Basin,2,1)="I" then Ocean="Indian";
	else if substr(Basin,2,1)="A" then Ocean="Atlantic";
	else Ocean="Pacific";
	drop EndDate;
	length Ocean $ 8;
run;

proc contents data=storm_complete;
run;

/*showing the compilation and excution of the data step*/

data storm_complete;
	set pg2.storm_summary_small(obs=2); 
	*this putlog is for the complimation;
    putlog "NOTE: (use uppercase and include the colon)";
	putlog _all_; 
	length Ocean $ 8;
	drop EndDate;
	where Name is not missing;
	Basin=upcase(Basin);
	StormLength=EndDate-StartDate;
	putlog StormLength=;
	if substr(Basin,2,1)="I" then Ocean="Indian";
	else if substr(Basin,2,1)="A" then Ocean="Atlantic";
	else Ocean="Pacific";
	*this putlog is for the excution;
	putlog "PDV Before RUN Statement";
	putlog _all_; 
run;
