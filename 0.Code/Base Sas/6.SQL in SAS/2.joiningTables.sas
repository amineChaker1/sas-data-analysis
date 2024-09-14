/*Joining Tables*/

proc sql;
select class_update.Name, Grade, Age, Teacher 
    from pg1.class_update inner join pg1.class_teachers
    on class_update.Name=class_teachers.Name;
quit;  

/*joining using aliases*/

proc sql;
select Season, Name, sum.Basin, BasinName, MaxWindMPH 
    from pg1.storm_summary as sum inner join pg1.storm_basincodes as bas
		on  sum.Basin = bas.Basin
	/*to get rid of the values that have no name*/
	where Name ^=" "
    order by Season desc, Name;
quit;