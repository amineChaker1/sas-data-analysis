/*freqeuncy report and graphs*/
ods noproctitle;
ods graphics;
title "Frequency Report";
proc freq data=pg1.storm_final order=freq nlevels;
	tables BasinName StartDate / nocum plots=freqplot(scale = percent) ;
	format StartDate monname.;
run;
title;
ods proctitle;

*creating two way frequency;

proc freq data=pg1.storm_final;
    tables BasinName*StartDate;
    format StartDate monname.;
run;

*you can modify it with adding many options;

proc freq data=pg1.storm_final;
    *nocol norow nopercent to keep only the frequency in the two way table;
    * crosslist to structure the table another way;
    tables BasinName*StartDate / list  ;
    format StartDate monname.;
run;

/*tests*/
title "Categories of Reported Species";
title " in the Everglades";
ods graphics;
proc freq data=pg1.np_species order=freq;
     where Species_ID like "EVER%" and Category ^= "Vascular Plant";
     tables Category / nocum plots=freqplot();
run;     

/*test2*/
title "Park Types by Region";
proc freq data=pg1.np_codelookup;
     tables Type*Region /nopercent list;
     where Type^=" ";
run;
     
title1 'Selected Park Types by Region';
ods graphics on;
proc freq data=pg1.np_codelookup order=freq;
    tables Type*Region /  nocol crosslist 
           plots=freqplot(groupby=row scale=grouppercent orient=horizontal);
    where Type in ('National Historic Site', 'National Monument', 'National Park');
run;
title;     
     