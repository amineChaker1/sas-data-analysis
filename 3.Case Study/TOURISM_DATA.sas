/*Tourism Data*/
data cleaned_tourism;
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
     
run;

