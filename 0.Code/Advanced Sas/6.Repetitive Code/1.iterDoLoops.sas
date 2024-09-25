/*iterative Do loops*/
*S&P500 eX;
data final;
    Reserve = 7000;
    do Year = 1 to 15;
       Reserve + 6000;
       Reserve = Reserve + Reserve * 0.1;
    end;
run;

*do loop with printing output each iterate;
data YearlySavings;
   Amount=200;
   do Month=1 to 12;
      Savings+Amount;
	  Savings+(Savings*0.02/12);
	  output;
   end;
   format Savings 12.2;
run;

*nested loops with only one output;
data retirement;
    do Year = 1 to 6;
       Invest+10000;
       do Quarter=1 to 4;
           Invest+(Invest*(.075/4));
           *output;
       end;
       output;
    end;
    drop Quarter;
run;

title1 'Retirement Account Balance per Year';
proc print data=retirement noobs;
    format Invest dollar12.2;
run;
title;

*nested loops inside and around an if then ;
data ForecastDayVisits;  
    set pg2.np_summary;
    where Reg='PW' and Type in ('NM','NP');
    ForecastDV=DayVisits;
    NextYear=year(today())+1;

    do Year = NextYear to NextYear+4;
       if Type='NM' then ForecastDV=ForecastDV*1.05;
       if Type='NP' then ForecastDV=ForecastDV*1.08;
       output;
    end;

    format ForecastDV comma12.;
    label ForecastDV='Forecasted Recreational Day Visitors';
    keep ParkName DayVisits ForecastDV Year;
run;

proc sort data=ForecastDayVisits;
    by ParkName;
run;

title 'Forecast of Recreational Day Visitors for Pacific West';
proc print data=ForecastDayVisits label;
run;
title;