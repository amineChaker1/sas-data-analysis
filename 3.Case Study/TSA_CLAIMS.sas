%let tsapath=/home/u63945741/ECRB94/data;
libname tsa "/home/u63945741/4.Case Study/data";

option validvarname = v7;

proc import datafile="&tsapath/TSAClaims2002_2017.csv" dbms=csv out=tsa.ClaimsImported replace;
    GUESSINGROWS=MAX;
run;

proc sort data=tsa.ClaimsImported out=tsa.Claims_NoDups noduprecs;
     by _all_;
run;

proc sort data=tsa.Claims_NoDups;
    by Incident_Date;
run;

data claims_clean;
    set tsa.Claims_NoDups;
    if Claim_Type in ("","-") then Claim_Type = "Unknown";
    if Claim_Site in ("","-") then Claim_Site = "Unknown";
    if Disposition in ("","-")  then Disposition= "Unknown";
       else if Disposition = "losed: Contractor Claim" then Disposition = "Closed:Contractor Claim";
       else if Disposition = "Closed: Canceled" then Disposition = "Closed:Canceled";
    where Claim_Type in ("Bus Terminal", "Complaint", "Compliment", "Employee Loss (MPCECA)", "Missed Flight", "Motor Vehicle",
    "Not Provided","Passenger Property Loss", "Passenger Theft", "Personal Injury",
    "Property Damage", "Property Loss", "Unknown", "Wrongful Death") 
    and Claim_Site in ("Bus Station", "Checked Baggage", "Checkpoint", "Motor Vehicle", "Not Provided", "Other",
    "Pre-Check","Unknown")
    and Disposition in ("*Insufficient", "Approve in Full", "Closed:Canceled", "Closed:Contractor Claim", "Deny", "In Review",
    "Pending Payment","Received","Settle","Unknown");
    StateName = upcase(StateName);
    State = upcase(State);
run;

    
