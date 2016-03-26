#Load the shiny package
library(shiny)
library(tm)

#Define UI for the shiny application here
shinyUI(fluidPage(
  headerPanel(title="Which are the most common strings on .fr domains?"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel( 
      radioButtons("type", 
                   "String type:",
                   c("Prefix" = "prefix", "Suffix" = "suffix"), 
                   selected = "prefix"),
      numericInput(inputId="n", "Number of letters:", value = 7, min=3, max=7),

      dateInput(inputId="day", label="Day of domain registration:", value="2015-02-03",
                min = min(DT$Datedecreation), max = max(DT$Datedecreation), 
                format = "yyyy-mm-dd", startview = "month", weekstart = 0),
      
      actionButton("update", "Change"),
      hr(),
      sliderInput("freq",
                  "Minimum Frequency:",
                  min = 1,  max = 10, value = 5),
      sliderInput("max",
                  "Maximum Number of Words:",
                  min = 1,  max = 100,  value = 50),
      
      helpText("Data source: Afnic"),
      helpText("http://opendata.afnic.fr Feb 2016"),
      helpText("Due to performance issues,"),
      helpText("just domains registered in 2015 are evaluated")

    ),
    
    # Show Word Cloud
    mainPanel(
      tabsetPanel(
        tabPanel("Word cloud", plotOutput("plot")), 
        tabPanel("Table", tableOutput("table"))
      )
    )
  )
))

