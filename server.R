library(shiny)
library(datasets)
library(splitstackshape)
library(party)

titan<-as.data.frame(Titanic)
titan_train<-expandRows(titan, count=5)
titan_ctree=ctree(formula=Survived ~ .,data=titan_train)


shinyServer(
  function(input, output) {
    c<-reactive({input$class})
    s<-reactive({input$sex})
    a<-reactive({input$age})
    #x <-renderTable({as.data.frame(reactiveValuesToList(subset(titan_train, Class == c() & Sex== s() & Age == a())))
    #})
    x <-reactive({
          as.data.frame(subset(titan_train, Class == c() & Sex== s() & Age == a()))
      })
    #surv<-reactive({as.data.frame(unlist(treeresponse(titan_ctree,x()))[c(2)])})  
    ##surv<-reactive({treeresponse(titan_ctree,x())}) 
    response<-reactive({unlist(head(treeresponse(titan_ctree,x()),n=1))
      })
    #surv<-reactive({as.data.frame(reactiveValuesToList(response()))})
    #surv<-reactive({as.character(response([2])})
    output$text1 <- renderText({paste0("* The Cabin Class you selected is: ",input$class)})
    output$text2 <- renderText({paste0("* The Sex you selected is: ",input$sex)})
    output$text3 <- renderText({paste0("* The Age you selected is: ",input$age)})
    #output$text4 <- renderText({response()[2]})
    output$text4 <- renderText({paste0("Your probability of survival is: ",format(round(response()[2]*100),2),"%")})
    output$Tree <- renderPlot({
                    plot(titan_ctree,cex=0.7)
                    })
})