/*Accumilating Values*/
*using retain and sum;

data zurich2017;
	set pg2.weather_zurich;
	retain TotalRain 0 ;
	TotalRain=sum(TotalRain,Rain_mm);
run;

*using the plus wich does it all;

data totalTraffic;
    set pg2.np_yearlyTraffic;
    totTraffic+Count;
    keep ParkName Location Count totTraffic;
    format totTraffic comma10.1;
run;

/*conditional accumilating*/

data parkTypeTraffic;
    set pg2.np_yearlytraffic;
    where ParkType = "National Park" or ParkType = "National Monument";
    if ParkType = "National Monument" then MonumentTraffic + Count;
    else ParkTraffic + Count;
    format MonumentTraffic ParkTraffic comma10.1;
run;

title 'Accumulating Traffic Totals for Park Types';
proc print data=work.parktypetraffic;
    var ParkType ParkName Location Count MonumentTraffic 
        ParkTraffic;
run;
title;