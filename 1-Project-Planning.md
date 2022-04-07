# Variables of Interest
- Time period: 4 weeks within December 2021; Dec 1-29 (when a big wave of COVID occured)
- Main predictor: Income (per capita average of all households in a neighbourhood during the specific time period)
- Extra predictor variables of interest: minorities/ethnicities, household size (can do if we need to)
- Response: COVID cases (change in rate/proportion in each neighbourhood between weeks)

# Rough Procedure
1. Focus on December 2021 (peak of COVID cases)

2. Aggregate COVID cases in each neighbourhood in each week of that month, divide by population of the neighbourhood and multiply by 1000 (cases per 1000)

3. Aggregate income in each neighbourhood, find the average, and divide by the population to obtain average per capita income

4. Calculate difference in COVID rates between each week-pair (2-1, 3-2, 4-3)

5. Look at each week's (i.e., seperate analyses) change in COVID and its relationship with income
7. Looking at episode date rather than reported date 

As defined by Open Data Toronto 
Episode Date	
The episode date is a derived variable that best estimates when the disease was acquired, and refers to the earliest available date from: symptom onset (the first day that COVID-19 symptoms occurred), laboratory specimen collection date, or reported date.

Reported Date	
The date on which the case was reported to Toronto Public Health.

# Hypothesis
Unclear for now. While lower incomes may be more limited in what preventative measures they can take against COVID, higher incomes may travel more and have greater risk of getting COVID.

# Data
- Toronto open source COVID Data – 4 weeks of December (1st to 29th)
- Toronto Neighborhoods data – household sizes, income, etc.

# Analysis Plan

Chapters 19-26 deal with seeing if a single variable is random or not, while chapters 27-31 deal with regression analysis. For initial data exploration, we can use content from 19-26 like choropleth maps, SMAs and Moran’s I to explore the independent variable (e.g., see if it is random or not) + visualize the dependent variables w/ maps. For the actual data analysis, we do regression (start off simple with linear regression, content from 27/28), test the model’s residuals for randomness (use Moran’s I test + plotting them). If not random, redo the model (using remedial action, covered in 27/29), test the residuals, and repeat the previous steps if they're not random.

## Breakdown of Relevant Textbook Chapters 

This is so that it's easier for us to locate the code and other knowledge we want to use for the analysis.

### Chapter 19/20
- Initial data visualization methods
- Choropleth maps
    - remember to use rates
    - plot for each variable
- Cartograms

### Chapter 21/22
- Spatial weights matrix
- Spatial moving average (SMA)
    - Have different criteria for proximity
    - Plot the variable vs. its SMA to see if it is spatially autocorrelated

### Chapter 23/24
- related to 21/22
- Simulating null landscapes and calculating their SMAs to compare to the actual data
- Scatterplots of SMA:
    - Plot the line of best fit and compare to the 45 degree line; the closer it is, the more likely it is to be spatially autocorrelated
- Moran's I (global)
    - tests for spatial autocorrelation of a pattern
    - can get the statistic's value, use a hypothesis test (p-value), scatterplot to complement the hypothesis test

## Chapter 25/26
- Local Moran's I
    - Can see which areas contribute more to the autocorrelation (map the individual p-values of each sub-area)
    - use it to detect hot/cold spots
- G-statistic/function
    - Local concentration
    - We don't really use it much, I think we can just use Moran's I 

### Chapter 27/28
- Linear regression analysis
    - Analyzes the relationship between certain variables (can have more than one predictor variable)
    - Plot scatterplot of actual data points + regression line
- Need to check the model’s results: check if the residuals are random (if yes, model got all the pattern; if not, makes assumption of the model invalid)
    - to do this, map the residuals
    - and use Moran's I test to check if it's spatially autocorrelated (i.e., p-value should be big enough so that it makes you accept the null hypothesis)
- If the residuals are not random, need to adjust the model so that they are
    - variable transformations
    - add other covariates
    - try a regime change
- After making a new model, test the residuals again. If not random, repeat

### Chapter 29/30 
-	Continues off of 27/28
-	Talks about methods to correct the model if the residuals are not random:
-	Use a different functional form (e.g., transform the variables)
-	Add more independent variables that are relevant
-	If the functional form for the model isn’t clear, can use flexible functional forms (trend surface analysis), or use models with spatially-varying coefficients (Expansion method, geographically weighted regression)
-	As a last resort: use the spatial error model

## The Sample Project

Just so that we have a general idea of what kind of methods we should be using + how to explain them.

### Methods used for initial data exploration/visualization
For the dependent variable:
-	Choropleth maps of their dependent variable (for each year + for the average of the entire time period studied)
-	Cartogram of their dependent variable averages over the entire time period
-	Compared original data with simulated null landscapes by mapping their spatial moving averages + plotting their scatter plots
-	Calculated spatial autocorrelation for it too: plotted the scatterplot for Moran’s, and gave the Moran’s I value + the p-value from the hypothesis test (global)
-	Looked at local Moran’s I + plotted the HH, LL, etc. regions

For the independent variable:
-	Choropleth maps for each independent variable
-	Compared these choropleth maps to the one from the dependent variable

### Methods for the data analysis
-	Linear regression
    -	showed results of the linear regression (showed table + plot)
    -	Had a grey region around the line, I think I’ve seen something similar before in the textbook, but not for linear regression so I'm not sure how they got this. I don't think they explain it in their report either

### Analysis Section

They basically explained why they used each test, interpreted all their figures + tests, and then related the results to their research question. The structure generally was:
1.	Analyze whether our dependent variable is random or not (via methods described above)
2.	Since it is not random, find the process (compare the choropleth maps of the independent and dependent variables visually, then quantitatively analyze using regression with an independent variable, etc.)

But, they lost marks for **not analyzing the residuals for randomness and trying to correct the issue**, so we should remember to do that (through the methods explained above in chapter 29/30). 

# Concerns 
- Time-lag of reported COVID cases/deaths
- How many times should we try and correct the model before we use the spatial error model to force the residuals to become random?

# Rubric
10% Introduction – Make sure that there is a clear and concise research question. The introduction is engaging, states the main topic and previews the structure of the paper.

20% Background – Literature review is relevant, up to date, and complete. The background provides a conceptual or theoretical framework to support the analysis in the paper.

20% Data and Methods – The methods are correctly described. Sources of data are properly documented. The format in which the data are used is clearly and precisely described.

20% Analysis – Descriptive statistics of the dataset are present. All parts of the analysis are relevant to the research question, and their use is justified. There is no redundancy in presentation. All methods are correctly applied.

15% Conclusions and Recommendations** – The conclusion speaks directly to the research question, and is supported by the analysis.

10% Presentation – Presentation is professional, with a title page, title, appropriate use of headings and subheadings, and a formatted list of references.

5% Extra mile – Correct application of a method or tool not covered in the course.

The final report in the example by Akhtar, Kalinina, Morrone, Walters, and Wu earned a 91/100. In this report, the students identified an interesting data set (the Washington Post opioids database), learned the tools to work with it, and presented an interesting analysis complemented with data from the census. The project had a clear research question (the potential statistical relationship between opioid prescriptions and various indicators of socio-economic deprivation); various methods from the course were used, the discussion was on point, and the presentation professional. The final grade of the project would have been a 100/100 if the residuals had been analyzed for spatial autocorrelation, and the results of this analysis had been discussed (and any issues had been corrected).

