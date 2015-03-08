library(shinythemes)
shinyUI(fluidPage(
  theme = shinytheme("journal"),
  
  titlePanel("Sentiment visualization of US leaders, source - Twitter/ Ranfor.com"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Observe sentiment polarity and locations of various US Leaders"),
      
      selectInput("varLeader", 
                  label = "Choose a leader to display",
                  choices = c("Barack Obama", "Hillary Clinton",
                              "Joe Biden", "Andrew Cuomo", "Bernie Sanders",
                              "Reince Priebus", "Jerry Brown", "Kirsten Gillibrand",
                              "Jeb Bush","Mike Huckabee", "Marco Rubio" ),
                  selected = "Barack Obama"),
      
      checkboxGroupInput("typeSentiment", "Sentiment types", c( "Positive" = "P", "Negative" = "N", "Neutral" = "O")
                         , selected = c("Positive", "Negative", "Neutral"), inline = FALSE)
     
      ,  uiOutput("choose_dates")
      ,actionButton("goButton", "Go!")
      #, submitButton("Submit")
    ),
   
    mainPanel(
      h4(textOutput("caption")), 
      textOutput("ranfor"), a("Android users -> Find me on Google Play.", href = "https://play.google.com/store/apps/details?id=com.ranfor.androidapp.pulseusa.elec.core"), 
      htmlOutput("gvis")
      
      )
  )
))

