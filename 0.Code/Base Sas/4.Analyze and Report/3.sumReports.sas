/*creating summary reprots*/

proc means data=pg1.storm_final mean median min max maxdec=0;
    var MaxWindMPH;
    *the class does the same thing as By but without the sorting;
    class BasinName StormType;
    *ways gives diffrent outputs for the enhanced reports;
    ways 0 1 2 ;
run;

/*tests*/
title "Weather Statistics by Year and Park";
proc means data=pg1.np_westweather mean min max maxdec=2;
    var Precip Snow TempMin TempMax;
    class Year Name;
run;

/*summary reprots with output table*/

proc means data=pg1.np_westweather noprint;
    where Precip ne 0;
    var Precip;
    class Name Year;
    ways 2;
    output out=rainstats n=RainDays sum=TotalRain;
run;

title1 'Rain Statistics by Year and Park';
proc print data=rainstats label noobs;
    var Name Year RainDays TotalRain;
    label Name='Park Name'
          RainDays='Number of Days Raining'
          TotalRain='Total Rain Amount (inches)';
run;
title;
