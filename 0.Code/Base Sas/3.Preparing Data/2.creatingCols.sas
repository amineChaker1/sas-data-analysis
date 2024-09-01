/*creating new columns*/

data Storm_cat5;
     set pg1.storm_summary;
     where MaxWindMPH >= 156 and StartDate >= "01JAN2000"d;
     MaxWindKM = MaxWindMPH * 1.60934;
     format MaxWindKM 3.;
     keep Season Basin Name Type MaxWindMPH MaxWindKM;
run;

/*you can find functions that can make creating new cols flexible*/
*gives the range of 4 cols;
data storm_wingavg;
	set pg1.storm_range;
	WindRange = range(wind1, wind2, wind3, wind4);
run;
*substrings words from cols;
data pacific;
	set pg1.storm_summary;
	drop Type Hem_EW Hem_NS MinPressure Lat Lon;
	where substr(Basin , 2 , 1) = "P";
run;
*date functions;
data eu_occ_total;
    set pg1.eu_occ;
    Year = substr(YearMon,1,4);
    Month = substr(YearMon,6,2);
    ReportDate = mdy(Month,1,Year);
    Total = sum(Hotel, ShortStay, Camp);
    format Hotel ShortStay Camp COMMA8.0 ReportDate MONYY7.;
    keep Country Hotel ShortStay Camp ReportDate Total;
run;
    
    
   