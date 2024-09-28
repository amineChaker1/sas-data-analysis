/*Tourism Data*/

/*data cleaned_tourism;
     set cr.tourism;
     length Category $ 80;
     if A ^=. then Country_Name = Country;
     
     if Country = "Outbound tourism" then Tourism_Type = "Outbound tourism";
     else if Country = "Inbound tourism" then Tourism_Type = "Inbound tourism";
     else if Country = Country_Name then Tourism_Type = "Inbound tourism";
     else if Country = "Arrivals - Thousands" then Category = "Arrivals";
     else if Country = "Departures - Thousands" then Category = "Departures";
     else if Country = "Passenger transport - US$ Mn" then Category = "Passenger transport - US$";
     else if Country = "Tourism expenditure in other countries - US$ Mn" then Category = "Tourism expenditure in other countries - US$";
     else if Country = "Tourism expenditure in the country - US$ Mn" then Category = "Tourism expenditure in the country - US$";
     else if Country = "Travel - US$ Mn" then Category = "Travel - US$";
     
     if Series = ".." or Series="" then Series = "MIS";
     Series = upcase(Series);

     if Category in ("Arrivals","Departures") then Y2014= _2014*1000;
     else if Category in ("Passenger transport - US$","Tourism expenditure in other countries - US$",
     "Tourism expenditure in the country - US$","Travel - US$") then Y2014= _2014*1000000;
     else if Category in ("Passenger transport - US$","Tourism expenditure in other countries - US$",
     "Tourism expenditure in the country - US$","Travel - US$");
     
     retain Tourism_Type Country_Name;
     keep Tourism_Type Country_Name Category Series Y2014;
     
     
run;*/

data cr.cleaned_tourism;
	length Country_Name $300 Tourism_Type $20;
	retain Country_Name "" Tourism_Type "";
	set cr.Tourism(drop=_1995-_2013);
	if A ne . then Country_Name=Country;
	if lowcase(Country)="inbound tourism" then Tourism_Type ="Inbound tourism";
		else if lowcase(Country)="outbound tourism" then Tourism_Type="Outbound tourism";
	if Country_Name ne Country and Country ne Tourism_Type;
	series=upcase(series);
	if series=".." then Series="";
	ConversionType=scan(country,-1," ");
	if _2014=".." then _2014=".";
	if ConversionType ="Mn" then do;
		if _2014 ne "." then Y2014 = input(_2014,16.)*1000000;
			else Y2014=.;
		Category=cat(scan(country,1,'-','r'),' -US$');
	end;
	else if ConversionType ="Thousands" then do;
		if _2014 ne "." then Y2014 = input(_2014,16.)*1000;
			else Y2014=.;
		Category=scan(country,1,'-','r');
	end;
	format y2014 comma25.;
	drop A ConversionType Country _2014;
run;

proc freq data=cr.cleaned_tourism;
	tables Category Tourism_Type Series;
run;

proc means data=cr.cleaned_tourism min max n maxdec=0;
	var Y2014;
run;

/* Create the Final_Tourism Table */
/* 1. Create a format for the Continent column that labels continent IDs with the corresponding continent names: */
/*
proc format;
	value contIDs
		1 = "North America"
		2 = "South America"
		3 = "Europe"
		4 = "Africa"
		5 = "Asia"
		6 = "Oceania"
		7 = "Antarctica";
run;
*/
/* 2. Merge the cleaned_tourism table with a sorted version of country_info to create the final_tourism table.
 Include only matches in the output table. Use the new format to format Continent. */
/*
proc sort data=cr.country_info(rename=(Country=Country_Name))
			out=country_sorted;
		by country_name;
run;
*/
/* Create the NoCountryFound Table */
/*
data cr.final_tourism 
	NoCountryFound(keep=Country_Name);
	merge cr.cleaned_tourism(in=t) Country_Sorted(in=c);
	by country_name;
	if t=1 and c=1 then output cr.Final_Tourism;
	if (t=1 and c=0) and first.country_name=1 then output NoCountryFound;
	format continent contIDs.;
run;

proc freq data=cr.final_tourism nlevels;
	tables category series Tourism_Type Continent /nocum nopercent;
run;
*/
/* QUIZ */
/*
proc means data=cr.final_tourism mean min max maxdec=0;	
	var y2014;
	class Continent;
	where Category="Arrivals";
run;

proc means data=cr.final_tourism mean maxdec=0;	
	var y2014;
	where lowcase(Category) contains "tourism expenditure in other countries";
run;
*/