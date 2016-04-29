library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("Would you have Survived the Sinking Titanic?"),
  sidebarPanel(
    selectInput("class", "Select your Cabin Class:",c("1st","2nd","3rd","Crew")),
    selectInput("sex", "Select your Sex:",c("Male","Female")),
    selectInput("age", "Select your Age:",c("Adult","Child")),
    submitButton("Submit")
  ),
  mainPanel(
    h4("This application provides the probabiliy of surviving the sinking Titanic based on 
       user input in the form of Cabin Class, Sex and Age. Please select a value from the drop down menu 
       and look for the app to display your probability of survival. Good luck!"),
    h4("The chart at the bottom is a ctree plot of how the decision tree algorithm arrives 
       at the survival probability. This can be used to get an overall understanding of how the various inputs
       impact the chances to survive."),
    h3("Here are your Selections:"),
    div(),
    h4(textOutput('text1')),
    h4(textOutput('text2')),
    h4(textOutput('text3')),
      span(h3(strong(textOutput('text4')),style = "color:blue")),
      h2('Probability Tree for Survival'), plotOutput('Tree')
      
  )
))