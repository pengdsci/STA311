/*****************************
         Weekly Quiz08
          10/27/2020
******************************/

/** Problem 2 **/

DATA index_comparison;
  string = 'I have a catfish and a cat named bob';
  index_result = INDEX(string,'cat');
  indexc_result= INDEXC(string,'cat');
  indexw_result = INDEXW(string,'cat');
RUN;
 
PROC PRINT DATA = index_comparison;
VAR string index_result indexc_result indexw_result;
RUN;


/* Problem 3 */

DATA COMPRESS_FUN;
TEXT = "the abc 123/%!?+ qWerty § Ref 19.3-20,9";
A1 = COMPRESS(TEXT, ' 1', 'dk');
A2 = COMPRESS(TEXT, '1', 'dk');
A3 = COMPRESS(A1, '123');
A4 = COMPRESS(A2, '123');
/** **/
KEEP A1 A2 A3 A4;
RUN;

PROC PRINT DATA = COMPRESS_FUN;
RUN;
 
/*** Problem 4  ***/

DATA BP;
INPUT BP $10.;
I=FIND(BP,"/");
SBP=INPUT(SUBSTR(BP,1,I-1),3.); * get number before the /;
DBP=INPUT(SUBSTR(BP,I+1),3.);   * get number after the /;
DROP I;
DATALINES;
120/80
140/90
110/70
;
RUN;
PROC PRINT DATA=BP;RUN;


DATA BP2;
INPUT BP $ 10.;
SBP=INPUT(SUBSTR(BP,1,3),3.);   
DBP=INPUT(SUBSTR(BP,5), 3.);    
DATALINES;
120/80
140/90
110/70
;
RUN;

PROC PRINT DATA = BP2;
RUN;

DATA BP3;
INPUT BP $ 10.;
SBP=INPUT(SUBSTR(BP,1,3),3.);  * get number before the /;
DBP=INPUT(SUBSTR(BP,5), 3.);   * get number after the /;
DROP I;
DATALINES;
120/80
140/90
110/70
;
RUN;

PROC PRINT DATA=BP3;RUN;

DATA BP4;
INPUT BP $10.;
POS = SCAN(BP, '/');
SBP=INPUT(SUBSTR(BP,1,POS-1),3.);   
DBP=INPUT(SUBSTR(BP,POS+1, 8), 3.);  
DATALINES;
120/80
140/90
110/70
;
RUN;

PROC PRINT DATA=BP4;RUN;

DATA BP5;
INPUT BP $ 10.;
POS = SCAN(BP, '/');
SBP=INPUT(SUBSTR(BP,1,POS),3.);   
DBP=INPUT(SUBSTR(BP,5), 3.);   
DATALINES;
120/80
140/90
110/70
;
RUN;

PROC PRINT DATA=BP5;RUN;


/** Problem 5 **/

DATA CAT_FUN;
  var_1 = '<';
  var_2 = 'space-right ';
  var_3 = 'no-space';
  var_4 = ' space-left';
  var_5 = ' space-both ';
  var_6 = '>';
  sep   = ',';
  mycat = cat (      var_1, var_2, var_3, var_4, var_5, var_6);  /* remove no spaces:                                     */ 
  mycats = cats(     var_1, var_2, var_3, var_4, var_5, var_6);  /* remove leading and trailing spaces:                   */
  mycatt = catt(     var_1, var_2, var_3, var_4, var_5, var_6);  /* remove traling spaces only:                           */ 
  mycatx = catx(sep, var_1, var_2, var_3, var_4, var_5, var_6);  /* insert seperator, remove leading and traling spacces: */
  KEEP mycat  mycats  mycatt  mycatx;
RUN;

PROC PRINT DATA= CAT_FUN;
RUN;



/** Problem 6  **/

DATA BIRTHDAY_GAME;
/** CAUTION: Please PROVIDE following information */
my_lucky_number = 10;   /* Pick any number between 2 and 10 */
/* DOB **/
my_BIRTH_YEAR = 1993;  /* 4 digit year */ 
my_BIRTH_MONTH = 11;   /* choosen from: 1, 2, 3, ...., 11, 12 */
my_Birth_DATE = 29;    /* choosen from: 1, 2, 3, ..., 30, 31 */
/****************************************************************/
/****    Next few statements use the functions we learnt    *****/ 
/****       in past two weeks to create a SAS data set      *****/
/****************************************************************/
/* Some SAS date functions and arithmetic operations learnt last week */
DT = TODAY(); 
YR = YEAR(DT);
MOD_DOB = MDY(my_BIRTH_MONTH, my_Birth_DATE,YR);
DIF_DOB = DT - MOD_DOB;
IF DIF_DOB > 0 THEN MAGIC_NUMBER = (50*(my_lucky_number*2 + 5)+ 1770 - my_BIRTH_YEAR);
ELSE MAGIC_NUMBER = (50*(my_lucky_number*2 + 5)+ 1769 - my_BIRTH_YEAR);
/* Some strings function we learnt this week */
LEN = LENGTH(MAGIC_NUMBER);
NUMBER01 = SUBSTR(MAGIC_NUMBER, 1, LEN-2);
NUMBER02 = SUBSTR(MAGIC_NUMBER, LEN-1);
KEEP NUMBER01 NUMBER02; 
RUN;

PROC PRINT DATA = BIRTHDAY_GAME;
RUN;


/** Problem 7 **/

DATA Problem7;
 Value=2000;
 DO year=1 TO 20;
 Interest=value*.075;
 value+interest;
 OUTPUT;
 END;
RUN;

/** Problem 8 **/
DATA PROBLEM8;
 DO year=1990 TO 2004;
 Capital+5000;
 capital+(capital*.10);
 OUTPUT;
 END; 

/** Problem 9 **/
DATA BANKS;
INPUT BANKS_NAME $ RATE;
DATALINES;
FirstCapital          0.0718
DirectBank          0.0721
VirtualDirect       0.0728
;
RUN;


Data Newbank;
SET BANKS;
DO year = 1 TO 4;
capital + 5000;
END;
RUN;

PROC PRINT DATA = Newbank;
RUN;



/** Problem 10 **/

DATA sales;
 DO year = 1 TO 5;
    DO month = 1 TO 12;
    x+ 1;
    OUTPUT;
    END;
 END;
RUN;



/** Problem 11 **/

DATA combine;
 prefix='505';
 middle='6465';
 end='09090';
total01 = COMPRESS(cat('-', prefix, middle, end));
total02 = COMPRESS(catx('-', prefix, middle, end));
total03 = COMPRESS(prefix ||'-'||  middle ||'-'|| end);
total04 = COMPRESS(prefix||'-'|| left(middle)||'-'|| end);

RUN;

PROC PRINT DATA = combine;
RUN;






/* Problem 12*/

DATA two; 
addressl = '214 London Way';  
address = tranwrd(addressl,'Way', 'Drive'); 
RUN; 

PROC PRINT DATA = two;RUN;

PROC CONTENTS DATA = two;
RUN;






