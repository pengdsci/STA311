
/*********************************
    SAS Code for Weekly Quiz 05
***********************************/

*** load covid-19 to SAS;

PROC IMPORT OUT= us_county_covid19 
            DATAFILE= "C:\Users\75CPENG\OneDrive - West Chester University of PA\Desktop\cpeng\WCU-Teaching\2020Fall\STA311\w07\us-counties.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

PROC CONTENTS DATA = us_county_covid19;
RUN;

/* Sort the dataset by STATE, COUNTY, and DATE */
PROC SORT DATA = us_county_covid19;
BY STATE COUNTY DATE;
RUN;

/* Check the date of the first covid-19 in each county */
DATA FIRST_DATE;
SET us_county_covid19;
BY STATE COUNTY DATE;
IF FIRST.COUNTY;
RUN;

/* The date of the latest observed COVID-19 */
DATA LAST_DATE;
SET us_county_covid19;
BY STATE COUNTY DATE;
IF LAST.COUNTY;
RUN;

/*
#    Variable    Type    Len    Format       Informat

5    cases       Num       8    BEST12.      BEST32.
2    county      Char     11    $11.         $11.
1    date        Num       8    MMDDYY10.    MMDDYY10.
6    deaths      Num       8    BEST12.      BEST32.
4    fips        Num       8    BEST12.      BEST32.
3    state       Char     10    $10.         $10.

FIPS = federal information process system - CODE
*/


/** Problem 5 **/
PROC FREQ DATA = us_county_covid19;
TABLE STATE;
RUN;


/*
Problem 6. 
Create a covid-19 data set for PA and find which county 
had the most records (i.e., the first PA COVID-19 case was observed 
in that county). 
*/
DATA COVID19_PA;
SET us_county_covid19;
IF STATE = 'Pennsylvan';
RUN; 

/** create county data: Find the names of counties in PA  **/
PROC FREQ DATA = covid19_PA;
TABLE COUNTY / OUT = freq_table;
RUN;

PROC CONTENTS DATA = freq_table;
RUN;

PROC SORT DATA = freq_table;
BY COUNT;
RUN;

PROC PRINT DATA = freq_table;
RUN;



/** Problem 7. & 8  **/
DATA Sept27;
SET COVID19_PA;
IF DATE ='27SEP2020'd;
RUN;

PROC SORT DATA = Sept27;
BY DEATHS;
RUN;

PROC PRINT DATA = SEPT27;
RUN;

/** Problem 9 **/

DATA NY;
SET us_county_covid19;
IF STATE = 'New York';
RUN;

DATA NY_27SEP;
SET NY;
IF DATE = '27SEP2020'd;
RUN;

PROC PRINT DATA = NY_27SEP;
RUN;


/** Problem 10.  **/

DATA COUNTY_IDENTIFIER;
SET us_county_covid19;
/* the new variable that uniquely identifies the county */
STATE_COUNTY = COMPRESS(STATE||'_'||COUNTY); 
RUN;

PROC FREQ DATA = COUNTY_IDENTIFIER;
TABLE STATE_COUNTY/OUT=COUNTY_FRQ;
RUN;

PROC CONTENTS DATA = COUNTY_FRQ;
RUN;

PROC SORT DATA= COUNTY_FRQ;
BY DESCENDING COUNT;
RUN;











