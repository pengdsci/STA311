/************************************
              MAT311 
     SAS code used for Quiz 06
          -- Week #8
************************************/


DATA dataset01;
INPUT name $ score;
DATALINES;
David 30
Ram 25
Sam 74
Sandy 36
;
RUN;

DATA dataset02;
INPUT name $ score;
DATALINES;
Ken 36
Obama 74
Raj 30
Shyam 25
;
RUN;


/** Problem 01 **/

DATA One2One;
  SET Dataset01;
  SET Dataset02;
RUN;

PROC PRINT DATA = One2One;
RUN;

*Problem 2;


DATA Problem02;
  SET Dataset01;
  SET Dataset02(RENAME=(score=score02));
RUN;


PROC PRINT DATA = Problem02;
RUN;


DATA Problem03;
  SET Dataset01(DROP=name);
  SET Dataset02;
RUN;

PROC PRINT DATA = Problem03;
RUN;


*problem 4;


DATA dataset01;
INPUT name $ score;
DATALINES;
David 30
Ram 25
Sam 74
Sandy 36
;
RUN;

DATA dataset02;
INPUT name $ score;
DATALINES;
Ken 36
Obama 74
Raj 30
Shyam 25
;
RUN;

PROC SORT DATA = dataset01;
BY name;
RUN;

PROC SORT DATA = dataset02;
BY name;
RUN;

DATA Problem04;
  SET Dataset01(rename =(score = score01))
      Dataset02(rename =(score = score02));
  BY name;
RUN;

PROC PRINT DATA = problem05_1;
RUN;


*Problem 5;
DATA Problem05_1;
  SET Dataset01(rename =(score = score01))
      Dataset02(rename =(score = score02));
  BY name;
RUN;

DATA Problem05_2;
  SET Dataset01(rename =(score = score01))
      Dataset02(rename =(score = score02));
RUN;

PROC PRINT DATA = Problem05_1;
RUN;

PROC PRINT DATA = Problem05_2;
RUN;




DATA Problem06;
  SET Dataset01(IN = ghost01)
      Dataset02(IN = ghost02);
  BY name;
  IF ghost02;
RUN;

PROC PRINT DATA = Problem06;
RUN;


DATA Problem07;
  SET Dataset01(IN = ghost01)
      Dataset02(IN = ghost02);
  BY name;
  Source_ID = ghost02 +1;
RUN;


PROC PRINT DATA = Problem07;
RUN;


/*********************************************************/
/**  Problem 08  **/
DATA TOY;
LENGTH Description $ 15;
INPUT Code Description & $ CompanyCode;
DATALINES;
1202  Princess        1000
0101  Baby Doll       1000
1316  Animal Set      1000
3220  Model Train     1000
3201  Electric Truck  1000
4300  Animal Cards    2000
4400  Teddy Bear      2000
;
RUN;

DATA ToyGenderAge;
INPUT Code Gender $ AgeRangeLow AgeRangeHigh;
DATALINES;
1202 F 6 9
0101 F 4 9
1316 B 3 6
3220 M 6 9
3201 M 6 9
5500 M 2 6
;
RUN;

PROC SORT DATA = Toy;
BY Code;
RUN;

PROC SORT DATA = ToyGenderAge;
BY Code;
RUN;

DATA Merged_ToyGA_KeepOnlyMatched;
 MERGE Toy (IN = ghost01 keep=Code Description)
       ToyGenderAge (IN = ghost02);
 BY Code;
 IF ghost01*ghost02=1;
RUN;

PROC PRINT DATA = Merged_ToyGA_KeepOnlyMatched;
RUN;


/** Problem 9 **/

DATA Problem09_1;
 MERGE Toy (IN = ghost01 keep=Code Description)
       ToyGenderAge (IN = ghost02);
 BY Code;
 IF ghost01;
RUN;

PROC PRINT DATA = Problem09_1;
RUN;

DATA Problem09_2;
 MERGE Toy (IN = ghost01 keep=Code Description)
       ToyGenderAge (IN = ghost02);
 BY Code;
 IF ghost02;
 RUN;

PROC PRINT DATA = Problem09_2;
RUN;

/******  Problem 10  *******/
DATA TOY;
LENGTH Description $ 15;
INPUT Code Description & $ CompanyCode;
DATALINES;
1202  Princess        1000
0101  Baby Doll       1000
1316  Animal Set      1000
3220  Model Train     1000
3201  Electric Truck  1000
4300  Animal Cards    2000
4400  Teddy Bear      2000
;
RUN;

DATA Company;
LENGTH CompanyName $ 10;
INPUT CompanyCode CompanyName & $;
DATALINES;
1000 Kids Toys
2000 More Toys
;
RUN;

PROC SORT DATA =Toy; 
BY CompanyCode; 
RUN;

PROC SORT DATA=Company; 
BY CompanyCode; 
RUN;

DATA Merged_ToyCompany;
 MERGE Toy Company;
 BY CompanyCode;
 RUN;

PROC PRINT DATA = Merged_ToyCompany;
RUN;

/***** Problem 11;   ****/
DATA English;
INPUT StudentID Grade TeacherID $;
DATALINES; 
101 80 E02
102 70 E02
103 60 E01
103 80 E01
104 90 E02
;
RUN;

DATA Math;
INPUT StudentID Grade TeacherID $;
DATALINES;
101 70 M11
103 60 M11
104 80 M12
;
RUN;

PROC SORT DATA = English; 
BY StudentID; 
RUN;

PROC SORT DATA =Math; 
BY StudentID; 
RUN;

DATA Grades_wide;
MERGE English(IN = ghost01 rename=(Grade=English_Grade))
      Math(IN = ghost02 rename=(Grade=Math_Grade));
BY StudentID;
RUN;

DATA Grades_long;
SET English(IN = ghost01)
      Math(IN = ghost02);
BY StudentID;
IF ghost01 THEN Subj = 'English';
IF ghost02 THEN Subj = 'Math';
RUN;

PROC PRINT DATA = GRADES_wide;
RUN;

PROC PRINT DATA = GRADES_long;
RUN;





DATA factory;
INPUT CompanyCode FactoryCode FactoryState $;
DATALINES;
1000 1111 MD
1000 1112 NY
1000 1113 VT
2000 2221 AZ
2000 2222 ME
2000 2223 CA
;
RUN;
