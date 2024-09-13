*Defining library and var;
%let tsapath=/home/u63945741/ECRB94/data;
libname tsa "/home/u63945741/4.Case Study/data";

*the naming convention for sas;
option validvarname = v7;

*importing data and removing duplicates;
proc import datafile="&tsapath/TSAClaims2002_2017.csv" dbms=csv out=tsa.ClaimsImported replace;
    GUESSINGROWS=MAX;
run;

proc sort data=tsa.ClaimsImported out=tsa.Claims_NoDups noduprecs;
     by _all_;
run;

proc sort data=tsa.Claims_NoDups;
    by Incident_Date;
run;
*exploring the data and looking for what to clean;
proc contents data=tsa.CLAIMS_NODUPS;
run;

proc freq data=tsa.claims_nodups;
     tables Claim_Site Disposition Claim_Type / nocum nopercent;
run;

data claims_clean;
    set tsa.Claims_NoDups;
    if Claim_Site in ("","-") then Claim_Site = "Unknown";
    if Disposition in ("","-")  then Disposition= "Unknown";
       else if Disposition = "losed: Contractor Claim" then Disposition = "Closed:Contractor Claim";
       else if Disposition = "Closed: Canceled" then Disposition = "Closed:Canceled";
    if Claim_Type in ("","-") then Claim_Type = "Unknown";
       else if Claim_Type = "Passenger Property Loss/Personal Injur" then Claim_Type = "Passenger Property Loss";
       else if Claim_Type = "Passenger Property Loss/Personal Injury" then Claim_Type = "Passenger Property Loss";
       else if Claim_Type = "Property Damage/Personal Injury" then Claim_Type = "Property Damage";
    /* QUESTION HERE HOW CAN WE MAKE SURE THAT ALL VALUES ARE ACCORDED TO THE ONES WE NEED
    where Claim_Type in ("Bus Terminal", "Complaint", "Compliment", "Employee Loss (MPCECA)", "Missed Flight", "Motor Vehicle",
    "Not Provided","Passenger Property Loss", "Passenger Theft", "Personal Injury",
    "Property Damage", "Property Loss", "Unknown", "Wrongful Death") 
    and Claim_Site in ("Bus Station", "Checked Baggage", "Checkpoint", "Motor Vehicle", "Not Provided", "Other",
    "Pre-Check","Unknown")
    and Disposition in ("*Insufficient", "Approve in Full", "Closed:Canceled", "Closed:Contractor Claim", "Deny", "In Review",
    "Pending Payment","Received","Settle","Unknown");*/
   
    StateName = upcase(StateName);
    State = upcase(State);
    *a problem here in date recieved there are two cols;
    if ( Incident_Date > Date_Received or
    Incident_Date= . or
    Date_Received= . or
    year(Incident_Date) < 2002 or
    year(Incident_Date) > 2017 or
    year(Date_Received) < 2002 or
    year(Date_Received) > 2017 ) then Date_Issues="Needs Review";
    
    
    format Date_Received Incident_Date date9. Close_Amount dollar20.2;
    drop County City;
    
run;

*Checking that the data has been cleaned;
proc contents data=claims_clean;
run;

proc freq data=claims_clean order=freq;
     tables Claim_Site Disposition Claim_Type Date_Issues / nocum nopercent;
run;  
