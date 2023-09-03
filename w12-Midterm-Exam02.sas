/*****************  Exam #2  ************/


*Problem 1;

DATA TEMP; 
Char1='0123456789'; 
Char2=substr(Char1,3,4); 
RUN; 

PROC PRINT DATA = TEMP;
RUN;




*Problem 1;

*A;
DATA work.test;
capacity = 150;
IF 100 le capacity le 200 THEN
     airplanetype = 'Large' and staff = 10;
ELSE airplanetype = 'Small' and staff = 5;
RUN;

*B;
DATA  work.test;
capacity = 150;
IF 100 le capacity le 200 THEN
   DO;
     airplanetype = 'Large';
     staff = 10;
   END;
ELSE
  DO;
     airplanetype = 'Small';
     staff = 5;
  END;
RUN;

*C;
DATA work.test;
capacity = 150;
IF 100 le capacity le 200 THEN
  DO;
    airplanetype = 'Large';
    staff = 10;
ELSE
  DO;
    airplanetype = 'Small';
    staff = 5;
  END;
RUN;

*D;
DATA work.test;
capacity = 150;
IF 100 le capacity le 200 THEN;
   airplanetype = 'Small';
   staff = 5;
ELSE;
   airplanetype = 'Large';
   staff = 10;
RUN;


**Problem 2**;

DATA work.new;
   LENGTH word $7;
   amount = 7;
   IF amount = 5 THEN word = 'CAT';
   ELSE IF amount = 7 THEN word = 'DOG';
   ELSE word = 'NONE!!!';
   amount = 5;
RUN;


/** Problem 4 **/
DATA Problem3;
   Author = 'Agatha Christie';
  First = substr(scan(Author,1,' '),1 ,1);
RUN;

PROC PRINT DATA=Problem3; 
RUN;

PROC CONTENTS DATA=Problem3; 
RUN;


/* Problem 5 */
DATA Problem5;
First = 'lpswich, England';
City = substr(First,1,7);
City_Country = City||' , ' || 'England';
RUN;

PROC CONTENTS DATA = Problem5;
RUN;


/** Problem 6  **/
DATA DATASET01;
LENGTH Location $ 10.;
LENGTH Booking_date $ 10.;
INPUT Prod_ID $	Location $ Booking_Date $ Qty_MT  Discount_Dollar;
DATALINES;
A201    Delhi           12-Jan-17       4       10
A304    Chennai         12-Jan-17       5       20
A205    Mumbai          15-Jan-17       2       4
C406    Delhi_NCR       17-Jan-17       8       5
C203    Delhi_NCR       20-Jan-17       7       1
Z404    Mumbai          15-Jan-17       6       12
;
RUN;

DATA DATASET02;
LENGTH Location $ 10.
       Booking_date $ 10.;
INPUT Prod_ID $ Location $  Booking_Date $  Qty_MT Discount_Dollar;
DATALINES;
A210    Mumbai          14-Jan-17       10      10
A310    Mumbai          14-Jan-17       8       20
A354    Delhi           18-Jan-17       5       4
C406    Delhi           17-Jan-17       8       5
C203    Delhi           20-Jan-17       7       1
Z514    Delhi           18-Jan-17       10      15
;
RUN;

/** wrong **/
DATA COMB_Data;
MERGE DATASET01 DATASET02;
RUN;

/** wrong **/
DATA COMB_Data;
MERGE DATASET01 DATASET02;
BY LOCATION;
RUN;

/** correct!!! **/
DATA COMB_Data;
SET DATASET01 DATASET02;
RUN;

/** wrong **/
DATA COMB_Data;
SET DATASET01;
SET DATASET02;
RUN;

/** wrong **/
DATA COMB_Data;
SET DATASET01;
SET DATASET02;
BY LOCATION;
RUN;



/** Problem 7 **/
DATA Problem_07;
LENGTH Location $ 10.;
LENGTH Booking_date $ 10.;
INPUT Prod_ID $	Location $ Booking_Date $ Qty_MT  Discount_Dollar;
DATALINES;
A201    Delhi           12-Jan-17       4       10
A304    Chennai         12-Jan-17       5       20
A205    Mumbai          15-Jan-17       2       4
C406    Delhi_NCR       17-Jan-17       8       5
C203    Delhi_NCR       20-Jan-17       7       1
Z404    Mumbai          15-Jan-17       6       12
;
RUN;


DATA Problem7_Correct;
     SET Problem_07;
     IF Location="Delhi" THEN Location="Delhi_NCR";
RUN;
 
/* wrong */
DATA Problem7_Correct;
     FORMAT location $10.;
     SET Problem_07;
     IF Location="Delhi" THEN DO Location="Delhi_NCR";
RUN;
 
/* wrong */
DATA Problem7_Correct;
     LENGTH Location $10;
     FORMAT location $10.;
     SET Problem_07;
     WHILE Location="Delhi" DO Location="Delhi_NCR";
RUN;

/* wrong */
DATA Problem7_Correct;
     LENGTH Location $10;
     FORMAT location $10.;
     SET Problem_07;
     IF Location="Delhi" DO Location="Delhi_NCR" END;
RUN;



/** Problem 8 **/
DATA Problem08;
*LENGTH Name $13  Education $ 13;
INPUT Loan_ID $ Gender $ Name & $13. Dependents Education & $13. LoanAmount Property_Area $ Loan_Status $;
DATALINES;
LP001002  Male  Dr.Kunal       0          Graduate      145      Urban             Y
LP001003  Male  Mr. Faizan     1          Graduate      128      Rural             N
LP001005  Male  Miss. Swati    0          Graduate      66       Urban             Y
LP001006  Male  Miss. Deepika  0          Not Graduate  120      Urban             H
LP001008  Male  Master Ankit   0          Graduate      141      Urban             Y

;
RUN;

*A.;
DATA Problem8;
     SET Problem08;
     Salutation = scan(name, 1);
RUN;

*B.; /* wrong */
DATA Problem8;
     SET Problem08;
     Salutation = scan(name, -1);
RUN;

*C.;/* wrong */
DATA Problem8;
     SET Problem08;
     Salutation = scan(name, 0);
RUN;

*D.;/* wrong */
DATA Problem8;
     SET Problem08;
     Salutation = scan(name, " ",1);
RUN;

*E.;/* wrong */
DATA Problem8;
     SET Problem08;
     Salutation = scan(name, ".",1);
RUN;


/**** Problem 9  ****/

DATA Plot_Data;
INPUT Month $ Product1  Product2  Product3;
DATALINES;
Jan  30  38  39
Feb  35  43  47
Mar  68  70  78
Apr  18  26  26
May  25  31  33
Jun  29  36  40
Jul  34  38  47
Aug  34  37  43
Sep  36  43  51
Oct  34  36  43
Nov  32  34  40
Dec  33  43  44
;
RUN;

*A.;
ODS HTML;
PROC SGPLOT DATA = Plot_Data;
     SERIES X = Month Y = Product1; 
     SERIES X = Month Y = Product2;
     SERIES X = Month Y = Product3;
RUN;
ODS HTML CLOSE;


*B.;
ODS HTML;
PROC SGPLOT DATA = Plot_Data;
     X = Month;
     Y = Product1 Product2 Product3; 
RUN;
ODS HTML CLOSE;

*C.;
ODS HTML;
PROC SGPLOT DATA = Plot_Data;
     X = Month X = Month X = Month;
     Y = Product1 Product2 Product3;
RUN;
ODS HTML CLOSE;

*D.;
ODS HTML;
PROC SGPLOT DATA = Plot_Data;
     X = Month;
     Y = Product1 Product2 Product3;
RUN;
ODS HTML CLOSE;


/* Problem 10 */
DATA TEMP; 
  Char1='0123456789'; 
  Char2=substr(Char1,3,4); 
RUN; 

PROC PRINT DATA = TEMP;
RUN;


/* Problem 11 */

DATA PRICES;
INPUT Prodid $ price producttype $9. salesreturns;
DATALINES;
K125   5.10 NETWORK  152
B132S  2.34 HARDWARE 30010
R18KY2 1.29 SOFTWARE 255
3KL8BY 6.37 HARDWARE 12515
DY65DW 5.60 HARDWARE 455
DGTY23 4.55 HARDWARE 672
;
RUN;

* The following SAS program is submitted:;
DATA hware inter cheap;
SET prices(KEEP = producttype price);
IF price le 5.00;
IF producttype = 'HARDWARE' THEN OUTPUT hware; 
ELSE IF producttype = 'NETWORK' THEN OUTPUT inter; 
RUN;

DATA hware inter cheap;
SET prices(KEEP = producttype price);
IF price le 5.00;
IF producttype = 'HARDWARE' THEN OUTPUT hware;
IF price le 5.00; 
IF producttype = 'NETWORK' THEN OUTPUT inter; 
RUN;

DATA hware inter cheap;
SET prices(KEEP = producttype price);
IF producttype = 'HARDWARE' THEN OUTPUT hware; 
ELSE IF producttype = 'NETWORK' THEN OUTPUT inter; 
IF price le 5.00;
RUN;


/** Problem 12 **/

DATA CDRATES;
INPUT Institution & $14.	Rate	Years;
DATALINES;
Superior Bank	0.0817	5
FirstBank	0.0814	3
Citywide Bank	0.0806	4
;
RUN;

DATA  compare(drop=i);
   SET cdrates;
   Investment=5000;
   DO i = 1 TO Years;
      Investment+Rate*Investment;
	  OUTPUT;
   END;
RUN;

PROC PRINT DATA = compare;
RUN;



/** Problem 13 **/
data earnings;
   Earned=0;
   Rate = 0.03;
   Amount = 10000;
   do Count=1 to 12;
      Earned+(Amount+Earned)*(Rate/12);
      output;
   end;
   OUTPUT;
run;

PROC PRINT DATA = EARNINGS;
RUN;



