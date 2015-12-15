# Health Indicators in Utah Counties
## A Shiny App

There are 29 counties in the state of Utah, and Utah's Open Data Catalog makes a variety of health indicators for Utah counties in 2014 publicly available [here](https://opendata.utah.gov/Health/Health-Care-Indicators-By-Counties-In-Utah-2014/qmsu-gki4). This Shiny App explores these health indicators and how they may be related. Check out [the app](https://juliasilge.shinyapps.io/CountyHealthApp).

In the app you can
* choose which health indicators you would like to plot on the x- and y-axes
* highlight a county of interest (This is only available if values have been reported for that county for both x- and y-axis health indicators. For example, many counties in Utah are very rural with low populations and have zero HIV-positive people living in them. The HIV rate for these counties is not reported.)
* plot a linear regression
* calculate a correlation coefficient with 95% confidence interval

