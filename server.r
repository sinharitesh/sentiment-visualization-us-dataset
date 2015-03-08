library(shiny)
library(googleVis)

load("data/df.sentiment.Rdata")
load("data/df.datecheckbox.Rdata")
unique(df.sentiment$EntityName)
df.sentiment$Longitude <- round(df.sentiment$Longitude, 2)
df.sentiment$Latitude <- round(df.sentiment$Latitude, 2)
df.sentiment$loc=paste(df.sentiment$Latitude, df.sentiment$Longitude, sep=":")
df.sentiment <- df.sentiment[,-c(3, 4)]
datesID <- unique(df.sentiment$PeriodID)
datesValue <- as.character(unique(df.datecheckbox$PeriodValue))
## End Data arrange

getdefaultdata <- function()
{
  a <- subset(df.sentiment, df.sentiment$EntityName %in% c("Barack Obama"))
  return(a)
}

shinyServer(
  function(input, output) {
   
    selectedLeader <- reactive({
      input$varLeader
    })
    
   output$choose_dates <- renderUI({
      checkboxGroupInput("dt", "Choose dates", 
                         choices  = (datesID = datesValue ),
                         selected = datesValue)
    })
 
      getplotdata <- reactive({
      a <- subset(df.sentiment, df.sentiment$EntityName %in% input$varLeader)
      a <- subset(a, a$Type %in% input$typeSentiment)
      #if (length(input$dt) > 0)
      {
      a <- subset(a, as.Date(a$PeriodValue, "%d %B %Y") %in% as.Date(input$dt, "%d %B %Y"))
      }
      return(a)
    })
        
  output$caption <- renderText({
    input$varLeader
  }) 
#   output$helloworld <- renderText({
#   "Android users -> Find me on Google Play"
#     })  
  
  output$ranfor <- renderText({
    "This demonstration is provided with the help of sentiment analysis engine built by www.ranfor.com"
  })  
  output$gvis <- 
    renderGvis({
      if (input$goButton == 0)
        {pd <- getdefaultdata()}
      if (input$goButton > 0)
      {pd <- isolate(getplotdata())}
      
  
      gvisGeoChart(pd, locationvar='loc', colorvar='SentimentType', 
                   options=list( height=400, legend = "none",
                                 displayMode='markers',
                                 colorAxis="{values:[-1,0,1],
                                   colors:[\'red', \'yellow\', \'green']}", 
                                 sizeAxis ="{minSize: 3, maxSize: 3}", chartid = "Sentiment Map", backgroundColor.fill = 'white')
                 )
      
    })
    
  }
)


