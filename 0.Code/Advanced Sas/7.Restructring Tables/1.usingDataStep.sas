/*Restructring using data step*/

data class_wide;
	set pg2.class_test_narrow;
	by Name;
	keep Name Math Reading;
	if TestSubject="Math" then Math=TestScore;
	else if TestSubject="Reading" then Reading=TestScore;
run;

proc print data=pg2.np_2017camping(obs=10);
run;

data work.camping_narrow(drop=Tent RV Backcountry);
	set pg2.np_2017Camping;
	length CampType $11;
	format CampCount comma12.;
	CampType='Tent';
	CampCount=Tent;
	output;
	CampType='RV';
	CampCount=RV;
	output;
	CampType='Backcountry';
	CampCount=Backcountry;
	output;
run;

/*Conditional*/
data work.camping_wide;
	set pg2.np_2016Camping;
	by ParkName;
	keep ParkName Tent RV Backcountry;
	format Tent RV Backcountry comma12.;
	retain ParkName Tent RV Backcountry;
	if CampType='Tent' then Tent=CampCount;
	else if CampType='RV' then RV=CampCount;
	else if CampType='Backcountry' then Backcountry=CampCount;
	if last.ParkName;
run;
