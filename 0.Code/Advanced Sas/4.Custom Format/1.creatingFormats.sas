/*Creating Custom Formats*/

*character and numeric custom formats;
proc format;
    value $regfmt 'C'='Complete'
                  'I'='Incomplete';
    value hrange 50-57='Below Average'
                 58-60='Average'
                 61-70='Above Average';

proc print data=pg2.class_birthdate noobs;
    where Age=12;
    var Name Registration Height;
    format Registration $regfmt. Height hrange.;
run;

*we use this format to limit the results by decades and not get every day from these data;
proc format;
     value stdate low - '31DEC1999'd = "before 2000"
                  '31DEC1999'd - '31DEC2009'd = "the 2010's"
                  '31DEC2009'd - high = "the after 2010";
run;

proc freq data=pg2.storm_summary;
     tables Basin*StartDate / nocol norow;
     format StartDate stdate.;
run;

*limting ranges with numeric;
proc format;
    value psize low-<10000='Small'
                10000-<500000='Average'
                500000-high='Large';
run;

data np_parksize;
    set pg2.np_acres;
    ParkSize=put(GrossAcres, psize.);
    format GrossAcres comma16.;
run;
