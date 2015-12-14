library(ggplot2)

health <- read.csv("./Health_Care_Indicators_By_Counties_In_Utah_2014.csv",
                      stringsAsFactors = FALSE)
health <- health[c(-1),]
health[,3:67] <- lapply(health[,3:67], as.numeric)
health <- health[,c(2:5,17,18,22,24,27,31,34,38,42,44,48,51,55,60,63,64)]
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

shinyServer(function(input, output) {
        
        selectedData <- reactive({
                health[, c(1, 
                           which(myLabels == input$xcol), 
                           which(myLabels == input$ycol))]
        })

        myDataset <- reactive({
                rename <- selectedData()
                colnames(rename) <- c('County', 'selectedX', 'selectedY')
                rename
        })        
        
        output$myPlot <- renderPlot({p <- ggplot(data = myDataset(), 
                                                 aes(x = selectedX, y = selectedY)) +
                geom_point(alpha = 0.6, size = 5) +
                xlab(input$xcol) +
                ylab(input$ycol)
        if (input$lmline) p <- p + stat_smooth(method = "lm")
        p <- p + geom_point(data = subset(myDataset(), County == input$county), 
                            size = 7, colour = "maroon")
        

        p})
        
        output$corText <- renderText({
                if (input$getcor) {
                        myX = as.matrix(subset(myDataset(), select = selectedX))
                        myY = as.matrix(subset(myDataset(), select = selectedY))
                        myCor <- cor.test(myX, myY)
                        paste("The correlation coefficient for these two health indicators is",
                              round(myCor$estimate, digits = 3), "with a 95% confidence interval from",
                              round(myCor$conf.int[1], digits = 3), "to",
                              round(myCor$conf.int[2], digits = 3), ".")
                }
        })
})