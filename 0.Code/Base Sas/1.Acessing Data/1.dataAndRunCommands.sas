data classData;
	set sashelp.class;
run;

proc print data=classData;
run;

proc contents data="/home/u63945741/EPG1V2/data/storm_summary.sas7bdat";
run;