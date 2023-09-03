DM 'CLEAR LOG';
DM 'CLEAR OUT';
/*************************************************************************************************
                    STA 311   Stats Computing and Data Management
                                    Optional Term Project
                                         Spring 2021

                                 

PROJECT DESCRIPTION: This term project focuses on the visual description of the relationship
between the COVID-19 positivity and mortality rates and status of face mask-wearing and the 
population density using multiple data sources at US county-level data. The project involves
both data management and visual analytics. The objective of this project is to put together 
some of the topics we learned this semester to work on a real-world problem. The project has 
two major parts: data management and visual analysis.

Part I - Data Management: Three data sets in different formats will be used in this project. The
detailed steps for managing the three datasets and creating the final analytic data set are given
below. Please go to the course web page to download the three data sets and save them in a folder
on your computer. Make sure the Citrix SAS can access the files.

Part II - Analysis: You are expected to use PROC SGPLOT to make scatter plots to depict the 
the potential relationship between several pairs of variables that are explicitly given below.  

************************************************************************************************/

LIBNAME prj "a-folder-in-your-computer";

/*====================================================================
                    PART I:  Data Management
======================================================================*/


/*******************************************************************/
/***  Step 1:  Data set 1- The data set was created in mid-July.
/*******************************************************************/
/***
   Read the FaceMaskWearing data (in text format) to SAS to create a SAS data set using 
   the same name: FaceMaskWearing based on the following instruction:
   1. Using INFILE-INPUT method. Keep in mind that the first record in the data file is the
      names of variables.
   2. Change the original variable name COUNTYFP to FIPS (Federal Information Processing System.
   3. FIPS should NOT be specified as a character Code!
   4. Using the variables in the original data set to define four new variables in the form 
      of ratios using NEVER as the denominator:
      4.1. RARELY_NEVER = RARELY/NEVER 
      4.2. SOMETIMES_NEVER = SOMETIMES/NEVER 
      4.3. FREQ_NEVER = FREQUENTLY/NEVER 
      4.4. ALWAYS_NEVER = ALWAYS/NEVER 
   5. DROP variable ID from the data.
***/


/***********************************************************************************/
/** Step 2:  Data Set 2 - COVID Case and Desth Coutns Data   
/***********************************************************************************/

/**
This is a SAS data set, right click the link and save it to a the folder (library) 
you created for this project using original file name: COVID19July0725 (the data was 
collected on 07/25/2020 )
**/


/******************************************************************************/
/****         Step 3:  Data Set 3 - Population Density
/******************************************************************************/

/***
Using PROC IMPORT to load the CSV population size data to SAS and name the SAS data
set as USCountyPopulation.
****/
 
 /****************************************************************************/
/**               Step 4: Case and Death Rates  
/****************************************************************************/
/**
4.1. Merge USCountyPopulation and COVID19July0725
     by FIPS. Note: The two data sets must be sorted by FIPS before merging them.
4.2. Define two rates (1/10000):
     CaseRate = 10000*CASES/POPsize
     DeathRate =10000*Deathe/POPsize
4.3. DELETE all rows in which either CaseRate or DeathRate is missing.
**/

/********************************************************************/
/**             Step 5:  Final Analytic Data Set
/********************************************************************/
/**
Merge data sets CaseDaethRate and FaceMaskWearing using key FIPS and name the
final analytical dataset as STA311_PROJ_DATA.
5.1. Sort CaseDeathRate and FaceMaskWearing by FIPS before merging them.
5.2. DELETE all records where either CaseRate or DeathRate is missing.
5.3. Define a new variable: POPDENSITY = POPsize/LANsize.
5.4. DELETE records in which CaseRate > 500.
5.5. DELETE records in which POPDENSITY < 50. 
**/

/*====================================================================
                    PART II:  Anlysis
======================================================================*/

/***  Description: In this part, you are going to create several scatter
      plots using PROC SGPLOT. You can also consider adding a smooth curve
      (LOESS curve)to each of the scatter plots to facilitate the detection 
      of the relation between the two variables.

      A LOESS curve is a smooth curve estimated from the data that gives 
      a nonlinear relationship between the two variables. The following 
      examples show you how to create a scatter plot and then add a loess
      curve on the scatter plot. For convenience, I use the iris data in 
      the accompanying permanent library SAShelp.                    

      1. Use RTF file destination;
      2. Use a meaningful title for each plot;
 ***/

     ODS RTF PATH = "path-to-folder-to-save-the-image";  /* file location */ 

	 /** Scatter plot ONLY! **/
     TITLE "Simple Scatter Plot With PROC SGPLOT";        /* give a meaningful title */
     PROC SGPLOT DATA = sashelp.iris;                     /* SGPLOT */
	   /* scatter plot: option GROUP will be used to produce different types of points  */
       SCATTER X = sepallength Y = sepalwidth / GROUP = species;
     RUN;
     TITLE;    /* Clear the previous title */

     /** Scatter plot with a LOESS curve **/
     TITLE "Simple Scatter with a LOESS curve";           /* give a meaningful title */
     PROC SGPLOT DATA = sashelp.iris;                     /* SGPLOT */
	   /* scatter plot: option GROUP will be used to produce different types of points  */
	   LOESS X = sepallength Y = sepalwidth / LINEATTRS =(COLOR = red) 
                                              SMOOTH=0.25;
	   SCATTER X = sepallength Y = sepalwidth / GROUP = species;
     RUN;
     TITLE;    /* Clear the previous title */

     ODS RTF CLOSE;

/*-----
    One Sample Interpretation:  Based on the scatter plot and the loess curve, we can see that
	 (1). the SEPALWIDTH is increasing when SEPALLENGHT is on interval [42, 52];
	 (2). the SEPALWIDTH is decreasing when SEPALLENGHT is on interval [52, 61];
	 (3). the SEPALWIDTH is increasing when SEPALLENGHT is on interval [61, 80];
-------*/


/****************************************************************************************
OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
Please answer each of the following questions by (1) making a scatter plot with a loess curve; 
and (2) interpret the pattern from the pattern you can see from the plot. 
OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO
*****************************************************************************************/

ODS RTF FILE= "your-file-location\STA311project.rtf";
/***************
Question 1: What is the relationship between the case rate and death rate.
****************/

/***************
Question 2: What is the relationship between the population density and the case rate.
****************/

/***************
Question 3: What is the relationship between population density and the death rate.
****************/

/***************
Question 4: What is the relationship between the percentage of people who wore face 
           mask sometimes and the case rate.
****************/

/***************
Question 5: What is the relationship between the percentage of people who wore face 
           mask frequently and the case rate.
****************/

/***************
Question 6: What is the relationship between the percentage of people who wore face 
           mask rarely and the case rate.
****************/

ODS RTF CLOSE;


/*====================================================================
                        END OF THE OPTIONAL PROJECT
======================================================================*/



