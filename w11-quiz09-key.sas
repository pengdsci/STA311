/**************************************************
       Week 11 SAS ARRAY and RESTRUCTURING
***************************************************/

/**  Problem 2  **/
DATA Problem2;
SET OLD;
ARRAY AGENTS[4] $12 SALES1 - sALES4;
** other statements go here ....;
RUN;


/** Problem 3 **/
DATA Problem2;
SET OLD;
ARRAY AGENTS[*] _NUMERIC_;
** other statements go here ....;
RUN;


/** Problem 5 **/
DATA PROBLEM_5_0;
INPUT Name $ Weight1 Weight2 Weight3 Weight4 Weight5 Weight6;
DATALINES;
Alicia	153.4	151.9	151.7	148.6	145.5	145.9
Betsy	116.0	116.0	114.0	111.1	109.8	108.2
Brenda	151.2	149.0	147.7	146.4	145.1	143.7
Carl	149.0	146.8	145.5	144.2	142.9	141.5
Carmela	140.2	137.8	136.5	135.4	134.0	128.3
;
RUN;

PROC PRINT DATA = PROBLEM_5_0; 
RUN;

DATA PROBLEM_5;
SET PROBLEM_5_0;
ARRAY  wt[*] _NUMERIC_;
ARRAY  wgt_diff[5];
   DO I = 1 TO DIM(wgt_diff);
      wgt_diff[I] = wt[1]-wt[I+1];
   END;
RUN;

PROC PRINT DATA = PROBLEM_5;
RUN;

/** Problem 6 **/
DATA Weight0;
LENGTH subject $10.;
INPUT subject $ date $  weight;
DATALINES;
Brittany jan31 145
Ann jan31 153
Brittany feb28 146
Ann feb28 151
Brittany mar31 144
Ann mar31 150
;
RUN;

PROC SORT DATA  = WEIGHT0;
BY SUBJECT DATE;
RUN;

PROC PRINT DATA=WEIGHT0;
RUN;

DATA WIDE;
SET WEIGHT0;
BY SUBJECT DATE;
ARRAY WT[3];
RETAIN WT;
IF FIRST.SUBJECT = 1 THEN DO;
  IDX = 0;
  END;
  IDX = IDX + 1;
  WT[IDX] = weight;
IF LAST.SUBJECT;
   OUTPUT;
RUN;

PROC PRINT DATA = WIDE;
RUN;


/** Problem 7  **/
 
DATA CLASS;
INPUT Name $ Gender $ age height weight;
DATALINES;
Alfred      M      14     69.0      112.5
Alice       F      13     56.5       84.0
Barbara     F      13     65.3       98.0
Carol       F      14     62.8      102.5
Henry       M      14     63.5      102.5
;
RUN;

DATA TEMP_ARRAY;
SET CLASS;
ARRAY CHAR_ARR[*] _NUMERIC_;
ARRAY EMPTY[4];
ARRAY TEMP[4] _TEMPORARY_;
 DO I = 1 TO DIM(CHAR_ARR);
  CHAR_ARR[I] = TEMP[I];
 END;
RUN;

PROC PRINT DATA = TEMP_ARRAY;
RUN;














