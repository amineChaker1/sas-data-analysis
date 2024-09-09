%let tsapath=/home/u63945741/ECRB94/data;
libname tsa "/home/u63945741/4.Case Study/data";

option validvarname = v7;

proc import datafile="&tsapath/TSAClaims2002_2017.csv" dbms=csv out=tsa.ClaimsImported replace;
    GUESSINGROWS=MAX;
run;

data claims_clean;
    set tsa.claimsimported;
    if Claim_Type=" " then Claim_Type = "Unknown";
    if Claim_Site=" "  then Claim_Site = "Unknown";
    if Disposition=" " then Disposition= "Unknown";
run;

    
