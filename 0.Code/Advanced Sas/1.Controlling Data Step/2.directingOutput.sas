/*Directing Data Step Output*/

*controling when and where the data should be outputed;

data monument(drop=ParkType) park(drop=ParkType) other;
	set pg2.np_yearlytraffic(drop=Region);
	if ParkType = "National Monument" then output monument;
	else if ParkType = "National Park" then output park;
	else output other;
run;

data camping(keep=ParkName Month DayVisits CampTotal) lodging(keep=ParkName Month DayVisits LodgingOther);
    set pg2.np_2017;
    CampTotal = sum(CampingOther, CampingTent, CampingRV, CampingBackcountry);
    format CampTotal comma10.2;
    if CampTotal > 0 then output camping;
    if LodgingOther > 0 then output lodging;
run;

*controling kept columns based on the pdv processing;

data work.boots work.slipper; 
    set sashelp.shoes;
    FinalSales=Sales-Returns;
    Drop Sales Returns;
    if Product='Boot' then output boots;
    else if Product='Slipper' then
            output slipper;
run;
