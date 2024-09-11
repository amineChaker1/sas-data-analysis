/*exporting reports*/
/*exporting into excel*/

*Add ODS statement;
ods excel file="&outpath/pressure.xlsx" options(sheet_name="Values") STYLE=ANALYSIS;
title "Minimum Pressure Statistics by Basin";
ods noproctitle;
proc means data=pg1.storm_final mean median min maxdec=0;
    class BasinName;
    var MinPressure;
run;
ods excel options(sheet_name="Scatter Plot");
title "Correlation of Minimum Pressure and Maximum Wind";
proc sgscatter data=pg1.storm_final;
	plot minpressure*maxwindmph;
run;
title;  

*Add ODS statement;
ods excel close;
ods proctitle;

/*exporting into pdf*/

*startpage to eliminate the space between reports;
*pdftoc to control how mny levels in the bookmark of the pdf;
ods pdf file="&outpath/wind.pdf" startpage=no style=journal pdftoc=1;
ods noproctitle;

title "Wind Statistics by Basin";
proc means data=pg1.storm_final min mean median max maxdec=0;
    class BasinName;
    var MaxWindMPH;
run;

title "Distribution of Maximum Wind";
proc sgplot data=pg1.storm_final;
    histogram MaxWindMPH;
    density MaxWindMPH;
run; 
title;  

ods proctitle;
ods pdf close;