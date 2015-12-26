
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("Linear supply and demand grapher and solver"),
  
  # Sidebar with a slider input for number of bins
  sidebarPanel(
    helpText('This app solves equilibrum price and',
             'quantity provided inverse supply and',
             'demand functions.'),
    helpText('The inverse demand function is D(q)=b-aQ',
             'The inverse supply function is S(q)=d+cQ'),
    numericInput('demand_slope','Demand slope (a)',-0.75),
    numericInput('demand_intercept','Demand intercept (b)',15.625),
    numericInput('supply_slope','Supply slope (c)',0.4),
    numericInput('supply_intercept','Supply Intercept (d)',2.4)
  ),
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot"),
    verbatimTextOutput('textPlot')
  )
))
