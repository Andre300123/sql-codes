data cars;
set sashelp.cars;
run;

options obs=10;
proc print data=cars;
run;
options obs = 428;
proc means data=SASHELP.CARS chartype mean std min max n vardef=df;
	var MPG_Highway;
run;

proc freq data=SASHELP.CARS;
	tables Make / plots=(freqplot);
run;

data mpg_city2;
set sashelp.cars;
where mpg_city > 25;
where make="Honda" and "Toyota";
run;

proc print data = mpg_city2;
run;

data price_category;
set sashelp.cars;
if(msrp<25000)then price_category = "low";
if(25000<=msrp<=50000)then price_category = "medium";
if(msrp>50000)then price_category = "high"; 
run;

proc print data=price_category;
run;

proc freq data=price_category;
	tables price_category / plots=(freqplot);
run;

proc means data=WORK.PRICE_CATEGORY chartype mean;
	var MPG_City MPG_Highway;
	class price_category;
run;
proc export data= price_category
	outfile= "/home/u63899078/assignment2/price_category.csv"
	dbms= csv replace;
run;