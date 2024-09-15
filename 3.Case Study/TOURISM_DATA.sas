/*Tourism Data*/

data cleaned_tourism;
     set cr.tourism;
     if A ^=. then Country_Name = Country;
     if Country = "Outbound tourism" then Tourism_Type = "Outbound tourism";
     else if Country = "Inbound tourism" then Tourism_Type = "Inbound tourism";
     else if Country = Country_Name then Tourism_Type = "Inbound tourism";
     retain Country_Name Tourism_Type;
run;

