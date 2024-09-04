/*Enhancing Reports with Titles, Footnotes, and Labels*/

data cars_update;
    set sashelp.cars;
	keep Make Model MSRP Invoice AvgMPG;
	AvgMPG=mean(MPG_Highway, MPG_City);
	label MSRP="Manufacturer Suggested Retail Price"
	      Invoice = "Invoice Price"
          AvgMPG="Average Miles per Gallon";
run;

proc sort data=cars_update out=cors;
     By Make;
run;

proc means data=cors min mean max;
    var MSRP Invoice;
run;

proc print data=cors label noobs;
    By Make;
    var Make Model MSRP Invoice AvgMPG;
run;