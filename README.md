
<!-- README.md is generated from README.Rmd. Please edit that file -->

# Income as a Determinant of the Speed of Transmission: Study of the Fifth Wave of SARS-CoV-2 in Toronto, Ontario

Final Project Report submitted for ENVSOCTY 4GA3 Applied Spatial
Statistics (McMaster University, April 2022)

<!-- badges: start -->
<!-- badges: end -->

Jason Lam  
Emily Fletcher  
Syed Hammad Uddin  
Jenny Chau  
Pierce Bourgeois

<!--

```r
# Covid Cases (downloaded from https://open.toronto.ca/dataset/covid-19-cases-in-toronto/) See:
library(opendatatoronto)
library(dplyr)

# get package
package <- show_package("64b54586-6180-4485-83eb-81e8fae3b8fe")
package
#> # A tibble: 1 x 11
#>   title             id    topics civic_issues publisher excerpt dataset_category
#>   <chr>             <chr> <chr>  <chr>        <chr>     <chr>   <chr>           
#> 1 COVID-19 Cases i~ 64b5~ Health <NA>         Toronto ~ Line-l~ Table           
#> # ... with 4 more variables: num_resources <int>, formats <chr>,
#> #   refresh_rate <chr>, last_refreshed <date>

# get all resources for this package
resources <- list_package_resources("64b54586-6180-4485-83eb-81e8fae3b8fe")

# identify datastore resources; by default, Toronto Open Data sets datastore resource format to CSV for non-geospatial and GeoJSON for geospatial resources
datastore_resources <- filter(resources, tolower(format) %in% c('csv', 'geojson'))

# load the first datastore resource as a sample
data <- filter(datastore_resources, row_number()==1) %>% get_resource()
data
#> # A tibble: 32,000 x 18
#>     `_id` Assigned_ID `Outbreak Associated` `Age Group`   `Neighbourhood~` FSA  
#>     <int>       <int> <chr>                 <chr>         <chr>            <chr>
#>  1 180729      186960 Outbreak Associated   60 to 69 Yea~ Danforth-East Y~ M4C  
#>  2 180730      186962 Sporadic              30 to 39 Yea~ Waterfront Comm~ M5V  
#>  3 180731      186963 Sporadic              40 to 49 Yea~ Humbermede       M9M  
#>  4 180732      186964 Sporadic              30 to 39 Yea~ Englemount-Lawr~ M6A  
#>  5 180733      186965 Outbreak Associated   70 to 79 Yea~ Danforth-East Y~ M4C  
#>  6 180734      186966 Outbreak Associated   60 to 69 Yea~ Danforth-East Y~ M4C  
#>  7 180735      186967 Sporadic              30 to 39 Yea~ Westminster-Bra~ M2R  
#>  8 180736      186968 Sporadic              50 to 59 Yea~ Glenfield-Jane ~ M3L  
#>  9 180737      186969 Sporadic              60 to 69 Yea~ Westminster-Bra~ M2R  
#> 10 180738      186970 Sporadic              40 to 49 Yea~ Regent Park      M5A  
#> # ... with 31,990 more rows, and 12 more variables:
#> #   `Source of Infection` <chr>, Classification <chr>, `Episode Date` <chr>,
#> #   `Reported Date` <chr>, `Client Gender` <chr>, Outcome <chr>,
#> #   `Currently Hospitalized` <chr>, `Currently in ICU` <chr>,
#> #   `Currently Intubated` <chr>, `Ever Hospitalized` <chr>,
#> #   `Ever in ICU` <chr>, `Ever Intubated` <chr>
```
-->
<!--Command \newpage creates a page break, i.e., starts a new page-->
<!--\newpage-->
<!-- 
To cite references in your bibliography.bib file, use [@item] if you want it to be cited in brackets, or @item if you want it to be cited as Name (year). If you want to cite various items in brackets, separate them with semicolons [@item1; @item2]
-->

# Introduction

Since the first cases in 2019, the COVID-19 outbreak has taken the world
by storm. As of writing this (April 2022), there are over five hundred
million cases reported worldwide (World Health Organization 2022). With
its ability to rapidly spread, the COVID-19 has had profound
consequences in every facet of public and private life. Among these
include medical, economic, and social spaces (Baena-Díez et al. 2020).
Most importantly, these unsettling times have shone a light on
pre-existing disparities within national health systems. For many
researchers, this does not come as a surprise as socioeconomic factors
influencing health outcomes have been noted ubiquitously throughout the
world (Khalatbari-Soltani et al. 2020). According to Khalatbari-Soltani
et al. (2020), there is even a link between those socio-economically
disadvantaged and increased risk of infectious disease.  
This research continues in a vein of spatial statistical studies which
analyze COVID-19 incidence rates paired with a socio-economic factor.
Building upon Khalatabari-Soltani, et al. (2020) and the socio-economic
position (SEP) framework, this study seeks to examine the relationship
between income levels, population density, and percentage of young
adults against COVID-19 incidence rates. More specifically, the
overarching objective of this study is to analyze the relationship
between the noted socio-economic variables and incidence rates of
COVID-19 during the fifth wave in Toronto, Ontario, Canada.

# Background

## Factors Related to COVID-19 Incidence

A person’s income level affects how they go about their everyday lives.
The associated behavioural pattern has been linked to change in health
outcomes (Khalatbari-Soltani et al. 2020). Low income, for example,
affects housing condition and leads to more tight housing arrangements.
Such factors have been associated in the increased risk of infections
for pathogens such as tuberculosis (Khalatbari-Soltani et al. 2020).

In Ontario, from January 21 to June 30, 2022, the most attributed
workplace was manufacturing (Murti et al. 2021). Manufacturing accounted
for 45% of outbreaks which totaled 65% of outbreak cases. Another
notable sector was Transport and Warehousing (11% of outbreaks, 8% of
outbreak cases). In Toronto, it has been observed the COVID-19 first
infiltrate in high income communities before quickly spreading to lower
income communities (Mishra et al. 2022). According to Mishra et
al. (2022) lower income neighbourhoods were also defined by their higher
dwelling densities and greater proportion of occupations that could not
make the transition to remote work.

In addition, the susceptibility of adolescents (aged 10-19 years) and
youth (aged 15-24 years) to COVID-19 has been a controversial research
topic since the pandemic began (Rumain, Schneiderman, and Geliebter
2021). While several studies have concluded that young adults are
significantly less susceptible to COVID-19 than older adults, others
have found that the prevalence of COVID-19 for adolescents and youth to
be significantly greater than that of older adults (Rumain,
Schneiderman, and Geliebter 2021). In April 2021, COVID-19 cases were
rising rapidly for young Canadians, with cases being highest among those
aged 20 to 39 (Aziz 2021). Suggested factors that attribute to higher
COVID-19 incidence among younger people include the reopening of high
schools, colleges, and universities, larger and more frequent social
gatherings and non-compliance with public health guidelines due to
perceived low-risk of severe symptoms for the age group, and low income.
(Aleta and Moreno 2020). Health-related behaviours of younger adults may
also affect their susceptibility to COVID-19 infection (Abbasi 2020). In
an online national survey of adolescents and young adults, vaping and
the dual use of e-cigarettes and cigarettes heavily increased the
chances of COVID-19 diagnosis (Gaiha, Cheng, and Halpern-Felsher 2020).

Lastly, Toronto has the densest urban core in the province and is one of
the most densely populated regions in North America. This has made it
susceptible to the ability of COVID-19 to rapidly spread. To date, there
have been more than 300,000 reported cases with more than 4000 deaths
(City of Toronto 2021). Within the city, there are several pockets that
are denser than others, and this density is an important factor to look
at. Population density is a measure of spatial distribution of people
across space. In the case of Toronto, St James Town is the most densely
populated neighbourhood in the city (Canadian Urban Institute 2016).
Research around population density and its link to COVID-19
susceptibility is limited. Past literature has not shown a clear
relationship between the two, with some noting a positive correlation
(Hamidi and Hamidi 2021) while others deducing an insignificant
relationship \[Carozzi_Provenzano_Roth_2020\]. This, as suggested by the
entire catalogue of research, is connected to the regional variations
connected to density. Some denser areas may have better services to
limit their exposure to the virus, while others may be poorer and so may
be more susceptible to the virus. It is important to explore this
phenomenon in the context of Toronto, to understand the type of
relationship found in the city.

## COVID-19 Waves in Toronto

The first case of COVID-19 in Ontario (and Canada) was reported on
January 25, 2020 (Nielsen 2020). As the virus began to spread, Ontario
entered its first wave of COVID-19 on February 26, 2020. The first wave
of COVID-19 lasted 188 days, ending on August 31, 2020 (Public Health
Ontario 2021). As Ontario began loosening restrictions as part of its
3-stage reopening plan, people started getting together again, and
observed cases began to rise. Ontario’s second wave began September 2020
and ended in February 2021, with cases peaking in January 2021 (Public
Health Ontario 2021). The third wave in Ontario was driven by the Alpha
(B.1.1.7) variant, which was more transmissible (Detsky and Bogoch
2021). The third wave lasted from March to July 2021, and was the
largest wave yet, with the peak number of new cases in a day in Ontario
being 5067 (Public Health Ontario 2022). The emergence of the Delta
variant (B.1.617.2) caused a smaller and shorter fourth wave in Ontario
that lasted from August to October 2021. The largest number of new cases
reported in a day in Ontario during the fourth wave was 878.

| Wave | Associated Variant | Approx. Start  | Approx. End   | Peak Cases Per Day | Total Cases |
|:-----|:-------------------|:---------------|:--------------|:-------------------|:------------|
| 1st  | Original Strain    | February 2020  | August 2020   | 752                | 42,486      |
| 2nd  | Original Strain    | September 2020 | February 2021 | 4,168              | 260,643     |
| 3rd  | Alpha              | March 2021     | July 2021     | 5,067              | 24,7654     |
| 4th  | Delta              | August 2021    | October 2021  | 878                | 49,704      |
| 5th  | Omicron            | December 2022  | February 2022 | 19,373             | 469,955     |

Waves of COVID-19 in Ontario

The fifth wave of the pandemic lasted from the beginning of December
2021 until mid-February 2022. The catalyst for this was the emergence of
a new, highly transmissible variant called Omicron. The variant, which
was first reported globally in November 2021, has been thoroughly
researched due to its scale and rate of infection. This research
suggests that the variant is highly transmissible due to several
factors. This includes the fact that Omicron is more likely to evade
immunity from a previous infection, meaning that there is a high chance
that you can get re-infected with COVID-19 (Pulliam et al. 2021). Other
research suggests that the variant is up to 3.7% more infectious among
vaccinated citizens than its predecessors (Mohsin and Mahmud 2022).
During the fifth wave, it became the dominant strain and was responsible
for 95% infections globally. In Ontario, the first Omicron cases were
reported on November 28, 2021 (Government of Ontario 2021). During the
Omicron wave, the highest number of new cases reported for a single day
in the province was 19,373 (Public Health Ontario 2022).

This study will determine how average income, percentage of youths, and
population density may affect the change in COVID-19 case rates between
the first and last week of December 2021.

# Study area

The analysis was conducted at the neighbourhood level for the City of
Toronto (See Figure 1). ‘Neighbourhood’ is a geographic level
specifically designed by the City of Toronto. They were created by city
to help government and other planning organizations with obtaining
socio-economic data (City of Toronto 2017). In total there are 140
unique areas, and their boundaries are based on the Canadian Census
Track. Each neighbourhood may contain between two to five of these
census tracts. The geography of neighbourhood was chosen for this study,
as opposed to wards or dissemination blocks, not only to showcase acute
changes within populations but due to the availability of both COVID-19
and the socio-economic data. The large number neighbourhoods also enable
this study to capture diversity across the city.

![Neighbourhoods in Toronto, Ontario,
Canada](README_files/figure-gfm/unnamed-chunk-5-1.png)

# Data

The shapefile used to delineate and map Toronto’s neighbourhoods in this
study was obtained from the “Neighbourhoods” file in the City of Toronto
Open Data portal (City of Toronto 2022). Using the same portal, the
COVID-19 data was retrieved from the dataset “COVID-19 Cases in Toronto”
(Toronto Public Health 2022). The data was downloaded as a
comma-separated values (CSV) file. This data is updated weekly by the
city and reports each individual case as a record. The time period of
interest was December 2021, corresponding to a peak in COVID-19 cases
within the fifth wave of the pandemic in Ontario. The cases from the
first week of December 2021 (Dec. 1 - Dec. 7) and the last week
(Dec. 25 - Dec. 31) were filtered out and aggregated by neighbourhood.
The average income, percentage of youth (18-24), and population density
of each neighbourhood that was used in this study was derived from data
in the “Neighbourhood Profile” dataset retrieved from Toronto Open Data
(Toronto Social Development, Finance & Administration 2011). This
dataset documents demographic and socioeconomic information for each of
Toronto’s neighbourhoods, including total population and the number of
people of each age, using Canada’s census data held every 5 years.

# Methods

This study used RStudio to conduct the data pre-processing, that is
cleaning of the original datasets. A unique method was ran to covered
the date data in the COVID-19 case table into character data type. This
was so the records could be parsed in respect to this studies period of
interest.

The analysis was also done in RStudio using several R packages,
including spatstat, tidyverse, ggplot2, dplyr, gridExtra, patchwork, and
spdep to analyze the area data and find a potential relationship between
the chosen independent variables (average income, percentage of 18-24
year old individuals, population density) and the dependent variable
(fold change in COVID-19 case rates from the first to last week of
December 2021) for the neighbourhoods of Toronto. For the initial
visualization and analysis of the area data, choropleth maps and Moran’s
I were used to identify patterns in the data. Then, to gain more insight
on the process behind these patterns, regression analysis was used to
determine the relationship between the independent and dependent
variables.

This document was also written and exported through R-Markdown with
minimal adaptation from Steven V. Miller’s template for academic
manuscripts. See:
<http://svmiller.com/blog/2016/02/svm-r-markdown-manuscript/>\[<https://github.com/svmiller/svm-r-markdown-templates/blob/master/svm-latex-ms.tex>\]
and
(<https://github.com/svmiller/svm-r-markdown-templates/blob/master/svm-latex-ms.tex>)

The data and code used in this project can be found on Github:
<https://github.com/lamj54/4GA3-Project>. This document is also
available as a RMarkdown file, which includes both the code and the text
used to create this report.

<!--Data cleaning section-->

# Analysis

## Data Exploration

First, to obtain a preliminary understanding of trends in the data,
choropleth maps were used to visualize the fold change in COVID-19 cases
between the first and last week of December 2021 (Figure 2), per capita
income (Figure 3), population density (Figure 4), and the percentage of
18- to 24-year-old individuals in each neighbourhood in Toronto (Figure
5).

In Figure 2, it can be seen that the fold change for all neighbourhoods
in Toronto is positive, indicating that they all experienced an increase
in COVID-19 case rates in the last week of December 2021 compared to the
first week of December 2021. In particular, the neighbourhoods coloured
in a darker red and orange showed a significantly large fold change in
COVID-19 rates in comparison to other neighbourhoods, which possibly
signifies the location of COVID-19 hotspots during December 2021.
Accordingly, the neighbourhoods located close to such spots seem to have
relatively large fold changes as well, as shown through their light
orange colour. Neighbourhoods with smaller fold changes, seen in yellow
in the map, appear to be located further away from areas with more
intense fold changes.

![The change in COVID-19 rates (cases per 10,000) between the first and
last week of December 2021 in Toronto by
neighbourhood](README_files/figure-gfm/unnamed-chunk-21-1.png)

Neighbourhoods with greater average income appear darker in colour on
the map in Figure 3, showing that people with higher income tend to
concentrate near the center of Toronto. Other neighbourhoods with high
average income can be seen in the west of Toronto as well. From a visual
comparison of Figures 2 and 3, it looks like the neighbourhoods with
high average incomes have lower fold changes in COVID-19 case rates
while the neighbourhoods with the highest fold changes are those with
lower average incomes. In addition, the neighbourhoods with more
moderate fold changes in light orange are also low income
neighbourhoods. The neighbourhoods with the lowest fold changes in
COVID-19 case rates in light yellow correspond to relatively high income
areas as well. These comparisons suggest that average income is
negatively correlated with the change in COVID-19 case rates.

![The average income of individuals in Toronto by
neighbourhood](README_files/figure-gfm/unnamed-chunk-22-1.png)

From Figure 4, it seems that there may be a greater population density
in some of the neighbourhoods located towards the southern areas of
Toronto. Population density appears to be lower in neighbourhoods
located in the outskirts of the city. Comparing Figures 2 and 4, the
neighbourhoods with very large fold changes do not have particularly
high population densities, and the neighbourhoods with high population
densities do not seem to have very high fold changes. Neighbourhoods
with similar population densities appear to have different changes in
COVID-19 case rates, which may indicate that its relationship with
population density is very weak.

![The population density of each neighbourhood in
Toronto](README_files/figure-gfm/unnamed-chunk-23-1.png)

Looking at Figure 5, there are a cluster of neighbourhoods in the south
of Toronto, coloured in red, that have a particularly high percentage of
18- to 24-year-old individuals making up their population. In addition,
a neighbourhood located near the north, in dark orange, has a relatively
high percentage of 18- to 24-year-old individuals. Comparing this map to
Figure 2, it seems that the neighbourhoods with higher percentages of
youth have lower changes in COVID-19 case rates. Accordingly, the
neighbourhoods with high fold changes have a relatively small percentage
of youth in them. These observations may suggest that the percentage of
youth in a neighbourhood is actually negatively correlated with change
in COVID-19 rates.

![The percentage of 18 to 24 year old individuals in Toronto by
neighbourhood](README_files/figure-gfm/unnamed-chunk-24-1.png)

## Spatial autocorrelation

Before doing a regression analysis to determine the relationship between
the change in COVID-19 case rates and the predictor variables, an
analysis of the pattern in the change in COVID-19 case rates must first
be done. If its pattern is non-random, then regression analysis can be
used to provide more information about the process that is creating this
pattern.

To test whether a spatial pattern is random or non-random, Moran’s I, a
coefficient of spatial autocorrelation, can be calculated and used in a
hypothesis test that assesses for spatial randomness. The null
hypothesis of this test is that the pattern is spatially random.

The Moran’s I statistic for this data is 0.089308782 and the p-value of
the test is 0.01787. Since the p-value is less than 0.05, it is
sufficiently small enough to reject the null hypothesis with a high
degree of confidence. This means that the change in COVID-19 case rates
is spatially autocorrelated, not spatially random. As well, since the
Moran’s I statistic is positive, it suggests that it is a non-random
spatial pattern where high values tend to be with other high values, and
low values tend to be with other low values. This agrees with the visual
observation of the choropleth map of the change in COVID-19 case rates
in Figure 2.

![The categorization of neighbourhoods based on local Moran’s I, a
statistic that describes the autocorrelation of a specific location and
its contribution to the global Moran’s I
statistic](README_files/figure-gfm/unnamed-chunk-28-1.png)

Correspondingly, the map of local Moran’s I, which breaks down Moran’s I
to examine the contribution of each area to the statistic, in Figure 6,
shows that neighbourhoods with high fold changes are surrounded by other
neighbourhoods that have high fold changes as well. Such regions are
labelled “HH” for “High-High”. On the other hand, the neighbourhoods
with low fold changes in COVID-19 case rates are surrounded by those
with similarly low fold changes, which are labelled “LL” for “Low-Low”.
Other possible combinations are “HL” and “LH” (“High-Low” and
“Low-High”). Categorizing each neighbourhood in this way, in addition to
showing whether a neighbourhood’s local Moran’s I is statistically
significant and thus spatially autocorrelated, reveals the hot spots and
cold spots that contribute significantly to the global Moran’s I
statistic. From Figure 6, it can be seen that there are several hot
spots where COVID-19 case rates have increased significantly, displayed
in bright red on the map.

## Regression Analysis

### Results of the Model

Now knowing that the change in COVID-19 case rates in Toronto’s
neighbourhoods is not spatially random, the question is what is the
process behind the creation of this pattern? To gain more insight on
this, a regression analysis can be used to determine the relationship
between several independent variables and the changes in COVID-19 case
rate.

As seen in the results of the regression model in Table 2, the only
independent variable that is statistically significant in the model is
the average income of a neighbourhood. This is because the p-values for
average income, percentage of individuals aged 18-24, and population in
this model are 0.00462, 0.38397, and 0.28312 respectively. They indicate
whether or not the null hypothesis, which states that a variable is not
statistically significant in the regression model, should be rejected or
not. Since the p-value for average income is less than 0.05, it is small
enough to reject the null hypothesis with a high degree of confidence.
This means that average income helps to explain the variance in the
dependent variable, the change in COVID-19 case rates. On the other
hand, the p-values for percentage of 18- to 24-year-old individuals and
population density are large, leading to the null hypothesis being
accepted. As a result, these two variables do not contribute
significantly to the model. This result suggests that average income is
a factor that influences the pattern of changes in COVID-19 case rates
across Toronto’s neighbourhoods, while the percentage of 18- to
24-years-old individuals and population density are not.

Moreover, Table 2 shows that the coefficient for average income is
approximately -0.0003 (0.0002591 exactly), indicating that
neighbourhoods with higher average incomes have smaller changes in
COVID-19 case rates. Thus, higher income causes the growth in COVID-19
cases to slow, while lower income causes the growth in COVID-19 cases to
accelerate. This agrees with our initial hypothesis. Individuals with
lower income tend to have less means to protect themselves from
COVID-19, due to factors such as lower income jobs being less
accommodating of remote work.

### Model Diagnostics

To determine whether the model has successfully retrieved all of the
systematic pattern, its residuals need to be analyzed for randomness. If
the residuals are non-random, this means that the model has failed to
capture the entire pattern and must be adjusted to have random
residuals.

The residuals can first be visualized with a map by plotting the sign of
the residual for each neighbourhood (Figure 7). A positive residual
indicates that the model overestimates the change in COVID-19 case
rates, while a negative residual means that the model underestimates it.

![Map of the sign of the residuals from the regression model for each
neighbourhood](README_files/figure-gfm/unnamed-chunk-30-1.png)

From a visual observation of Figure 7, there does not appear to be any
obvious clusters of positive or negative residuals. To obtain a more
concrete conclusion, the Moran’s I coefficient can be used in a
hypothesis test again to test for spatial randomness.

The result of the Moran’s I hypothesis test supports the visual
observation of Figure 7. The null hypothesis of the test is that the
pattern analyzed is spatially random. The p-value is 0.1871, which is
greater than 0.05 and thus large enough to accept the null hypothesis.
Consequently, the residuals of this regression model is random,
indicating that the model successfully capture all of the pattern within
the changes in COVID-19 case rates across Toronto’s neighbourhoods. This
means that the model does not need to be adjusted since its assumption
that the residuals are independent has not been violated, so the results
obtained from the model (summarized in Table 2) are valid.

# Conclusion

Overall, the changes in COVID-19 case rates across neighbourhoods in
Toronto show spatial autocorrelation, as found using Moran’s I. A
regression analysis of the change in COVID-19 case rates with respect to
average income, percentage of 18- to 24-year-old individuals, and
population density was also done. It revealed that there is a connection
between average income and changes in the rates of COVID-19 cases, with
neighbourhoods with lower income having greater changes in COVID-19 case
rates. This means that a lower average income can quicken the growth in
COVID-19 cases. In addition, the results of the regression show that
other socio-economic factors, the percentage of 18- to 24-year olds and
the population density in a neighbourhood, did not have a clear
connection with the COVID-19 case changes. It is recommended that, for
the future, more research should be done on the relationship with
socio-economic variables and changes in COVID-19 cases. Socio-economic
factors are complex factors that need to be further explored to verify
the relationships found in this study.

Identifying groups of individuals from a socio-economic perspective is
the first step to establishing that a person’s socioeconomic position
may be as much of an indicator in predicting health outcomes as a
pre-existing medical condition. In establishing such similarities,
governing healthcare bodies may extend precautionary recommendations to
people with specific socio-economic conditions, thus providing a more
in-depth and informed disease prevention plan. In a pursuit of
identifying groups of the populations who are more susceptible to poorer
outcomes when combating health problems, more research in this area
needs to be undertaken.

# References

<div id="refs" class="references csl-bib-body hanging-indent">

<div id="ref-Abbasi_2020" class="csl-entry">

Abbasi, Jennifer. 2020. “Younger Adults Caught in COVID-19 Crosshairs as
Demographics Shift.” *JAMA* 324 (21): 2141–43.
<https://doi.org/10.1001/jama.2020.21913>.

</div>

<div id="ref-Aleta_Moreno_2020" class="csl-entry">

Aleta, Alberto, and Yamir Moreno. 2020. “Age Differential Analysis of
COVID-19 Second Wave in Europe Reveals Highest Incidence Among Young
Adults,” November, 2020.11.11.20230177.
<https://doi.org/10.1101/2020.11.11.20230177>.

</div>

<div id="ref-Aziz_2021" class="csl-entry">

Aziz, Saba. 2021. “‘Hit the Hardest’: Why COVID-19 Cases Are Rising
Among Young Canadians - National \| Globalnews.ca.” *Global News*.
<https://globalnews.ca/news/7731485/covid-variant-cases-young-canadians/>.

</div>

<div id="ref-Baena-Diez_Barroso_Cordeiro-Coelho_Diaz_Grau_2020"
class="csl-entry">

Baena-Díez, Jose Miguel, María Barroso, Sara Isabel Cordeiro-Coelho,
Jorge L. Díaz, and María Grau. 2020. “Impact of COVID-19 Outbreak by
Income: Hitting Hardest the Most Deprived.” *Journal of Public Health
(Oxford, England)* 42 (4): 698–703.
<https://doi.org/10.1093/pubmed/fdaa136>.

</div>

<div id="ref-CUI_2016" class="csl-entry">

Canadian Urban Institute. 2016. “TOcore Neighbourhood Population
Profiles,” July, 46.

</div>

<div id="ref-Toronto_2017" class="csl-entry">

City of Toronto. 2017. “Neighbourhood Profiles.” *City of Toronto*. City
of Toronto.
<https://www.toronto.ca/city-government/data-research-maps/neighbourhoods-communities/neighbourhood-profiles/>.

</div>

<div id="ref-Toronto_2021" class="csl-entry">

———. 2021. “COVID-19: Case Counts.” *City of Toronto*. City of Toronto.
<https://www.toronto.ca/home/covid-19/covid-19-pandemic-data/covid-19-weekday-status-of-cases-data/>.

</div>

<div id="ref-Toronto_2022" class="csl-entry">

———. 2022. “Neighborhood Shapefile.” Social Development, Finance &
Administration.

</div>

<div id="ref-Detsky_Bogoch_2021" class="csl-entry">

Detsky, Allan S., and Isaac I. Bogoch. 2021. “COVID-19 in Canada:
Experience and Response to Waves 2 and 3.” *JAMA* 326 (12): 1145–46.
<https://doi.org/10.1001/jama.2021.14797>.

</div>

<div id="ref-Gaiha_Cheng_Halpern-Felsher_2020" class="csl-entry">

Gaiha, Shivani Mathur, Jing Cheng, and Bonnie Halpern-Felsher. 2020.
“Association Between Youth Smoking, Electronic Cigarette Use, and
COVID-19.” *Journal of Adolescent Health* 67 (4): 519–23.
<https://doi.org/10.1016/j.jadohealth.2020.07.002>.

</div>

<div id="ref-GofO_2021" class="csl-entry">

Government of Ontario. 2021. “Ontario Confirms First Two Cases of
Omicron Variant.” Government. *News.ontario.ca*.
<https://news.ontario.ca/en/statement/1001241/ontario-confirms-first-two-cases-of-omicron-variant>.

</div>

<div id="ref-Hamidi_Hamidi_2021" class="csl-entry">

Hamidi, Shima, and Iman Hamidi. 2021. “Subway Ridership, Crowding, or
Population Density: Determinants of COVID-19 Infection Rates in New York
City.” *American Journal of Preventive Medicine* 60 (5): 614–20.
<https://doi.org/10.1016/j.amepre.2020.11.016>.

</div>

<div id="ref-Khalatbari-Soltani_Cumming_Delpierre_Kelly-Irving_2020"
class="csl-entry">

Khalatbari-Soltani, Saman, Robert C. Cumming, Cyrille Delpierre, and
Michelle Kelly-Irving. 2020. “Importance of Collecting Data on
Socioeconomic Determinants from the Early Stage of the COVID-19 Outbreak
Onwards.” *J Epidemiol Community Health* 74 (8): 620–23.
<https://doi.org/10.1136/jech-2020-214297>.

</div>

<div
id="ref-Mishra_Ma_Moloney_Yiu_Darvin_Landsman_Kwong_Calzavara_Straus_Chan_et_al_2022"
class="csl-entry">

Mishra, Sharmistha, Huiting Ma, Gary Moloney, Kristy C. Y. Yiu, Dariya
Darvin, David Landsman, Jeffrey C. Kwong, et al. 2022. “Increasing
Concentration of COVID-19 by Socioeconomic Determinants and Geography in
Toronto, Canada: An Observational Study.” *Annals of Epidemiology* 65
(January): 84–92. <https://doi.org/10.1016/j.annepidem.2021.07.007>.

</div>

<div id="ref-Mohsin_Mahmud_2022" class="csl-entry">

Mohsin, Md, and Sultan Mahmud. 2022. *Omicron SARS-CoV-2 Variant of
Concern: A Review on Its Transmissibility, Immune Evasion, Reinfection,
and Severity*. Preprint. In Review.
<https://doi.org/10.21203/rs.3.rs-1316171/v1>.

</div>

<div id="ref-Murti_Achonu_Smith_Brown_Kim_Johnson_Ravindran_Buchan_2021"
class="csl-entry">

Murti, Michelle, Camille Achonu, Brendan T. Smith, Kevin A. Brown, Jin
Hee Kim, James Johnson, Saranyah Ravindran, and Sarah A. Buchan. 2021.
“COVID-19 Workplace Outbreaks by Industry Sector and Their Associated
Household Transmission, Ontario, Canada, January – June, 2020.” *Journal
of Occupational & Environmental Medicine* Publish Ahead of Print
(April). <https://doi.org/10.1097/JOM.0000000000002201>.

</div>

<div id="ref-Nielsen_2020" class="csl-entry">

Nielsen, Kevin. 2020. “A Timeline of COVID-19 in Ontario \|
Globalnews.ca.” *Global News*.
<https://globalnews.ca/news/6859636/ontario-coronavirus-timeline/>.

</div>

<div id="ref-PHO_2021" class="csl-entry">

Public Health Ontario. 2021. “Hospitalizations and Deaths Among COVID-19
Cases in Ontario: Waves 1, 2, 3 and 4.” Public Health Ontario.
<https://www.publichealthontario.ca/-/media/documents/ncov/epi/covid-19-hospitalizations-deaths-ontario-quick-epi-summary.pdf?sc_lang=en>.

</div>

<div id="ref-PHO_2022" class="csl-entry">

———. 2022. “Ontario COVID-19 Data Tool.” Data Tool. *Public Health
Ontario*.
<https://www.publichealthontario.ca/en/Data-and-Analysis/Infectious-Disease/COVID-19-Data-Surveillance/COVID-19-Data-Tool>.

</div>

<div
id="ref-Pulliam_Schalkwyk_Govender_Gottberg_Cohen_Groome_Dushoff_Mlisana_Moultrie_2021"
class="csl-entry">

Pulliam, Juliet R. C., Cari van Schalkwyk, Nevashan Govender, Anne von
Gottberg, Cheryl Cohen, Michelle J. Groome, Jonathan Dushoff, Koleka
Mlisana, and Harry Moultrie. 2021. “Increased Risk of SARS-CoV-2
Reinfection Associated with Emergence of the Omicron Variant in South
Africa,” December, 2021.11.11.21266068.
<https://doi.org/10.1101/2021.11.11.21266068>.

</div>

<div id="ref-Rumain_Schneiderman_Geliebter_2021" class="csl-entry">

Rumain, Barbara, Moshe Schneiderman, and Allan Geliebter. 2021.
“Prevalence of COVID-19 in Adolescents and Youth Compared with Older
Adults in States Experiencing Surges.” *PloS One* 16 (3): e0242587.
<https://doi.org/10.1371/journal.pone.0242587>.

</div>

<div id="ref-TPH_2022" class="csl-entry">

Toronto Public Health. 2022. “COVID-19 Cases in Toronto.” City of
Toronto Open Data.
<https://open.toronto.ca/dataset/covid-19-cases-in-toronto/>.

</div>

<div id="ref-TSDFA_2011" class="csl-entry">

Toronto Social Development, Finance & Administration. 2011.
“Neighbourhood Profiles.” Open Data Toronto.
<https://open.toronto.ca/dataset/neighbourhood-profiles/>.

</div>

<div id="ref-WHO_2022" class="csl-entry">

World Health Organization. 2022. “WHO Coronavirus (COVID-19) Dashboard.”
<https://covid19.who.int>.

</div>

</div>
