/*Preparing Data*/

data Storm_cat5;
     set pg1.storm_summary;
     where MaxWindMPH >= 156 and StartDate >= "01JAN2000"d;
     keep Season Basin Name Type MaxWindMPH;
     *you can also use drop to exclude the columns you dont want;
run;

/*setting data filtering dropping and sorting*/

data fox;
     set pg1.np_species;
     where Category = "Mammal" and Common_Names like "%Fox%" and Common_Names not like "%Squirrel%";
     drop Category Record_Status Occurrence Nativeness;
run;

proc sort data=fox;
    by Common_Names;
run;