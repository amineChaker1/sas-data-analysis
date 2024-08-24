*listing rows of a table and ordering it and exploring the data;

proc print data=pg1.storm_summary (obs=10);
     var  Season Name Basin MaxWindMPH MinPressure StartDate EndDate;
run;

*calculating the means for some table values;
/*after running this command : The fact that these numbers are different means that there are quite
a few missing values for MinPressure compared to MaxWindMPH.
Specifically, I might want to look at the Minimum and Maximum to see if those ranges appear valid.
Six is a pretty small value for MaxWindMPH. We might want to investigate further to see if that's accurate.
And negative 9,999 is definitely not valid for MinPressure, so we may want to consider later on making
those values invalid or missing.*/

proc means data=pg1.storm_summary ;
     var MaxWindMPH MinPressure;
run;

/*how data variates*/

proc univariate data=pg1.storm_summary;
     var MaxWindMPH MinPressure;
run;

/*see the frequency of some variables and how many times the repeat*/
*we use tables instead of var;
proc freq data=pg1.storm_summary;
     tables Basin Type Season;
run;