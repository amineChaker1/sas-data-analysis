/*Concatenating Tables*/

*add to tables with the same col names and get rid of the diffreneces;
data class_current;
    length Name $9;
    set sashelp.class pg2.class_new2(rename=(Student=Name));
run;

*concatenate three tables and sort;
data work.np_combine;
    set pg2.np_2015 pg2.np_2016 ;
    drop Camping:;
    where Month = 6 or Month = 7 or Month = 8;
    CampTotal= sum(CampingOther, CampingTent, CampingRV, CampingBackcountry);
    format CampTotal comma10.1;
run;

data work.np_combine2;
    set pg2.np_2015 pg2.np_2016 pg2.np_2014 (rename=(Park=ParkCode Type=ParkType))  ;
    drop Camping:;
    where Month = 6 or Month = 7 or Month = 8;
    CampTotal= sum(CampingOther, CampingTent, CampingRV, CampingBackcountry);
    format CampTotal comma10.1;
    if ParkType = "National Park";
run;

proc sort data=np_combine2;
    by ParkType ParkCode Year Month;
run;