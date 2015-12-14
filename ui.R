health <- read.csv("./Health_Care_Indicators_By_Counties_In_Utah_2014.csv",
                   stringsAsFactors = FALSE)
myLabels <- c("County", "Population", "Population under 18 (percent)",
              "Population 65 and over (percent)", "Rural population (percent)",
              "Diabetic population (percent)", 
              "HIV rate (per 100,000 population)",
              "Premature mortality rate (per 100,000 population)",
              "Infant mortality rate (per 1000 live births)",
              "Child mortality rate (per 1000 live births)",
              "Food insecure (percent)", 
              "Motor vehicle death rate (per 100,000 population)",
              "Drug poisoning mortality rate (per 100,000 population)",
              "Uninsured population (percent)", "Uninsured children (percent)",
              "Health care costs (per person)", 
              "Could not see doctor due to cost (percent)",
              "Median household income (dollars)",
              "Children eligible for free lunch (percent)",
              "Homicide rate (per 100,000 population)")

shinyUI(fluidPage(
        titlePanel("Health Indicators in Utah Counties"),
        
        sidebarLayout(
                sidebarPanel("This interactive plot shows 2014 health indicators 
                             for the 29 counties in Utah.",
                             br(),
                             br(),
                             "Choose health indicators for the x and y variables 
                             in the plot, highlight a specific county (if values 
                             have been reported for both x and y health 
                             indicators), display a regression line, and 
                             calculate the correlation coefficient. The data 
                             used in these plots are publicly available at ", 
                             a("Utah's Open Data Catalog.", 
                               href = "https://opendata.utah.gov/Health/Health-Care-Indicators-By-Counties-In-Utah-2014/qmsu-gki4"),
                             br(),
                             br(),
                             selectInput('xcol', 'X Variable', myLabels[2:20],
                                         selected = myLabels[12]),
                             selectInput('ycol', 'Y Variable', myLabels[2:20],
                                         selected = myLabels[19]),
                             selectInput('county', 'Highlight a county (if available for both indicators)', health$County, 
                                         selected = "Salt Lake"),
                             checkboxInput('lmline', label = 'Linear regression', value = FALSE),
                             checkboxInput('getcor', label = 'Correlation coefficient', value = FALSE)
                ),
                mainPanel(
                        plotOutput('myPlot', height = 500),
                        br(),
                        br(),
                        textOutput('corText')
                        )
        )
))