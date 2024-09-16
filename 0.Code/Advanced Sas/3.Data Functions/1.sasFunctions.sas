/*Minupilating Data with Functions*/
*Numeric Functions;

data wind_avg;
	set pg2.storm_top4_wide;
	WindAvg1=round(mean(of Wind1-Wind4), .1) ; 
	WindAvg2=mean(of Wind1-Wind4); 
	format WindAvg2 comma5.1;
run;

proc print data=pg2.np_lodging(obs=10);
	where CL2010>0;
run;

data stays;
	set pg2.np_lodging;
	Stay1=largest(1,of CL2010-CL2017);
	Stay2=largest(2,of CL2010-CL2017); 
	Stay3=largest(3,of CL2010-CL2017);
	StayAvg= round(mean(of CL2010-CL2017));
	if StayAvg > 0;
	format Stay: comma11.;
	keep Park StayAvg Stay:;
run;

*Date Function;
/*function does not include the optional method argument, so the default discrete 
method is used to calculate the number of weekly boundaries (ending each Saturday)*/

/*you can use month too and it will count how many months has been crossed regularly 
and if you add c it will start from the date*/

data storm_length;
	set pg2.storm_final(obs=10);
	keep Season Name StartDate Enddate StormLength Weeks;
	Weeks=intck('week', StartDate, EndDate , 'C');
run;

data rainsummary;
	set pg2.np_hourlyrain;
	by Month;
	if first.Month=1 then MonthlyRainTotal=0;
	MonthlyRainTotal+Rain;
	if last.Month=1;
	Date = datepart(DateTime);
	MonthEnd = intnx("month", Date , 0 , "end");
	format Date MonthEnd date9.;
	keep StationName MonthlyRainTotal Date MonthEnd;
run;

