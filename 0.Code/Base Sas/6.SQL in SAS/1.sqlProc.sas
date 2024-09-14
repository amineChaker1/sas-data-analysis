/*using sql in sas*/

title "PROC SQL Output";
proc sql;
select Name, Age, Height*2.54 as HeightCM format=5.1, Birthdate format=date9.
    from pg1.class_birthdate;
quit;

title;
 
*Creating tables with sql commands;
 
title "Most Costly Storms";
proc sql;
   create table heavyHitters as
    select Event, Cost format=dollar10., year(Date) as Season
    from pg1.storm_damage
    where Cost > 25000000000 
    order by Cost desc;
quit;