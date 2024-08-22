/*to change the naming convention that it matches SAS*/

option validvarname=v7;

libname excelib xlsx "/home/u63945741/EPG1V2/data/storm.xlsx";

proc contents data = excelib.storm_summary;
run;

/*good practice to clear the library so it doesnt stay connected to the data after it's used*/

libname excelib clear;


