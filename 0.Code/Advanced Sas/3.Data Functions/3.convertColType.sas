/*Converting Col Type*/
*sometimes sas converts col types automatically and sometimes it dont;
data work.stocks2;
   set pg2.stocks2;
   Range=High-Low;
   DailyVol=Volume/30;
run;

proc print data=stocks2(obs=10);
run;

/*INPUT Function - converts characters to numbers*/
data atl_precip;
    set pg2.weather_atlanta(rename=(date=CharDate));
    where AirportCode = "ATL";
    drop AirportCode City Temp: ZipCode Precip CharDate;
    if Precip ^= "T" tehn PrecipNum=input(Precip,6.);
    else PrecipNum=0;
    TotalPrecip+PrecipNum;
    Date=input(CharDate, mmddyy10.);
    Format Date date9.;
run;

/* PUT Function - converts numbers to characters */
data atl_precip;
	set pg2.weather_atlanta;
	CityStateZip=catx(' ',City,'GA',ZipCode);
	ZipCodeLast2=substr(put(ZipCode, z5.) ,4,2);
run;