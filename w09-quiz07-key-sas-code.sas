/************************************
     Quiz 07  SAS Code
*************************************/

/** Please go to course web page to download
    the Nepal Trail Data and store the data
    in the local drive the SAS can asscess:
  
    You can use either data step (INFILE-INPUT), 
    PROC IMPORT, or INPUT WIZARD to load the
    data to SAS to create an SAS data set to
    answer some if the questions.          **/

PROC IMPORT OUT= Nepal_Trial_Data 
            DATAFILE= "C:\Users\75CPENG\OneDrive - West Chester University of PA\Desktop\cpeng\WCU-Teaching\2020Fall\STA311\w09-nepaltrialdata.csv" 
            DBMS=CSV REPLACE;
     GETNAMES=YES;
     DATAROW=2; 
RUN;

/** Checking variable names and types in the data set **/

PROC CONTENTS DATA = Nepal_Trial_Data;
TITLE "Nepal Trial Data";
RUN;


DATA Problem1;
INFILE "C:\Users\75CPENG\OneDrive - West Chester University of PA\Desktop\cpeng\WCU-Teaching\2020Fall\STA311\w09-nepaltrialdata.csv" 
DLM="," FIRSTOBS = 2;
*WT_ROUNDED = Round(WT, .1);
*HT_ROUNDED = Round(HT, .1);
*ARM_ROUNDED = Round(ARM, .1);
RUN;





/* Problem 1: Define a SAS dataset using the variables; */
DATA Nepal_Clean_Trial;
SET Nepal_Trial_Data;
VIS_DATE = MDY(month, day, year);
wt = ROUND(wt, .1);
ht = ROUND(ht, .1);
arm = ROUND(arm, .1);
IF WT > 90 THEN DELETE;
RUN;

PROC CONTENTS DATA = Nepal_Clean_Trial;
RUN;


/** Problem 2: Defining character format and converting variable type  **/
/**  INPUT():  ch -> num || PUT() num -> ch  **/

DATA Nepal_Trial_Dates;
SET Nepal_Clean_Trial;
VIS_DATE = MDY(MONTH, DAY, YEAR);
FORMAT VIS_DATE mmddyy10.;
DROP DIED ALIVE BF LIT DAY MONTH YEAR;
RUN;

PROC FREQ DATA = Nepal_Trial_Dates;
TABLE VIS_DATE;
*FORMAT mmddyy10.;
RUN;


/** Problem 03: First Vist Data **/
PROC SORT DATA = Nepal_Trial_Dates;
BY ID VIS_DATE;
RUN;

DATA Nepal_Trial_FIRST_VIS;
SET Nepal_Trial_Dates;
BY ID VIS_DATE;
IF FIRST.ID;
RUN;


/** Problem 04: Frequency table of SEX  **/

PROC FORMAT;
VALUE gender 1 = "male" 
             2 = "female";
RUN;

PROC FREQ DATA = Nepal_Trial_FIRST_VIS;
TABLE SEX;
FORMAT SEX gender.;
RUN;

/** Problem 05: Grouping mother's ages and age distribution  **/
/*   1 = “17-24”, 2 = “25-30”, 3 = “31 – 37”, 4 = “38-55”  */
DATA  Nepal_Trial_FIRST_VIS_MAGE;
SET Nepal_Trial_FIRST_VIS;
IF MAGE LE 24 THEN GRP_AGE = "17-24";
ELSE IF MAGE LE 30 THEN GRP_AGE = "25-30";
ELSE IF MAGE LE 37 THEN GRP_AGE = "31-37";
ELSE GRP_AGE = "38-55";
RUN;

PROC FREQ DATA =  Nepal_Trial_FIRST_VIS_MAGE;
TABLE GRP_AGE;
RUN;


/** Problem 6: duration between first and last visits **/
DATA Nepal_Trial_LAST_VIS;
SET Nepal_Trial_Dates;
BY ID VIS_DATE;
IF LAST.ID;
RUN;

DATA Nepal_Trial_Duration;
MERGE Nepal_Trial_LAST_VIS (KEEP = ID VIS_DATE RENAME=(VIS_DATE = FIRST_VIS) )
      Nepal_Trial_FIRST_VIS(KEEP = ID VIS_DATE RENAME=(VIS_DATE = LAST_VIS) );
BY ID;
DURATION = FIRST_VIS - LAST_VIS;
RUN;

PROC MEANS MIN Q1 Median Q3 MAX DATA = Nepal_Trial_Duration;
VAR DURATION;
RUN;

