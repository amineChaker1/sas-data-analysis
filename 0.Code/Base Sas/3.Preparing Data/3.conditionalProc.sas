/* Conditional Processing */
*using if and else and length statements so the words dont get cropped;
data park_type;
	set pg1.np_summary;
	length ParkType $ 8;
	if Type='NM' then ParkType='Monument';
	else if Type='NP' then ParkType='Park';
	else if Type in ('NPRE', 'PRE', 'PRESERVE') then ParkType='Preserve';
	else if Type='NS' then ParkType='Seashore';
	else if Type in ('RVR', 'RIVERWAYS') then ParkType='River';
run;

proc freq data=park_type;
	tables ParkType;
run;

/*filtering and making two tables for diffrent cases*/

data parks monuments;
    set pg1.np_summary;
    where Type = "NP" or Type = "NM";
    Campers = sum( BackcountryCampers, OtherCamping, RVCampers, TentCampers);
    format Campers COMAA7.0;
    if Type = "NP" then do;
        ParkType = "NP";
        output parks;
    end;
    else if Type = "NM" then do;
        ParkType = "NM";
        output monuments;
    end;
    keep Reg ParkName DayVisits OtherLodging Campers ParkType ;
   
run;