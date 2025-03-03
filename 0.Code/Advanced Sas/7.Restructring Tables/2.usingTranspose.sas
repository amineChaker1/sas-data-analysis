/*Using Transpose*/

proc print data=sashelp.class;
run;

proc transpose data=sashelp.class out=class_t;
     id Name;
     var Height Weight;
run;

/*renaming and grouping with By*/
proc print data=pg2.np_2017camping(obs=5);
run;

proc transpose data=pg2.np_2017camping out=work.camping2017_t(rename=(COL1=Count)) NAME=Location;
     By ParkName;
     Var Tent RV;
run;

proc transpose data=pg2.np_2016camping 
	           out=work.camping2016_t(drop=_name_);
	by ParkName;
	id CampType;
	var CampCount;
run;