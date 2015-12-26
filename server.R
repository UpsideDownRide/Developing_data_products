
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
   
  output$distPlot <- renderPlot({
    
        demand_slope <- input$demand_slope
        demand_intercept <- input$demand_intercept
        supply_slope <- input$supply_slope
        supply_intercept <- input$supply_intercept
        max_y <- ceiling(demand_intercept)
        max_x <- ceiling(-demand_intercept/demand_slope)
        q_equilibrum <- solve(demand_slope-supply_slope,-(demand_intercept-supply_intercept))
        p_equilibrum <- demand_slope*q_equilibrum+demand_intercept
        
        ggplot(data=NULL,aes(x=x,y=y))+
              geom_abline(aes(intercept=demand_intercept,slope=demand_slope),size=1.5)+
              labs(x='Quantity',y='Price')+
              geom_abline(aes(intercept=supply_intercept,slope=supply_slope),size=1.5)+
              geom_segment(aes(x=q_equilibrum,y=0,xend=q_equilibrum,yend=p_equilibrum),size=1.2,linetype=2)+
              geom_segment(aes(x=0,y=p_equilibrum,xend=q_equilibrum,yend=p_equilibrum),size=1.2,linetype=2)+
              scale_x_continuous(breaks=c(q_equilibrum,round(seq(0,max_x,length.out=4),2)),limits=c(0,max_x))+
              scale_y_continuous(breaks=c(p_equilibrum,round(seq(0,max_y,length.out=4),2)),limits=c(0,max_y))+
              annotate('text',label='Q*',x=q_equilibrum+0.015*max_x,y=0,size=5)+
              annotate('text',label='P*',x=0,y=p_equilibrum+0.015*max_y,size=5)
        
    })
  
  output$textPlot <- renderText({
        demand_slope <- input$demand_slope
        demand_intercept <- input$demand_intercept
        supply_slope <- input$supply_slope
        supply_intercept <- input$supply_intercept
        max_y <- ceiling(demand_intercept)
        max_x <- ceiling(-demand_intercept/demand_slope)
        q_equilibrum <- round(solve(demand_slope-supply_slope,-(demand_intercept-supply_intercept)),4)
        p_equilibrum <- round(demand_slope*q_equilibrum+demand_intercept,4)
        print(paste0('The equilibrum quantity is Q*=',q_equilibrum,'\n','The equilibrum price is P*=',p_equilibrum))
        
  })
  
})
