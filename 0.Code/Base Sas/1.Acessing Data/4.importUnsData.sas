/*importing unstructed data*/

proc import datafile="/home/u63945741/EPG1V2/data/storm_damage.csv" dbms=csv out= storm_damage_summary replace;
run;

proc contents data=storm_damage_summary;
run;