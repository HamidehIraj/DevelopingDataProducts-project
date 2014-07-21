library(shiny)
library(caret)
library(ggplot2)
data(iris)

inTrain  <- createDataPartition(y=iris$Species, p=0.7, list=FALSE)
training <- iris[inTrain,]
testing  <- iris[-inTrain,]

shinyServer(function(input, output, session) {
  output$myImage <- renderImage({
    # A temp file to save the output.
    # This file will be removed later by renderImage
    outfile <- tempfile(fileext='.png')
    
    
    kMeans1 <- kmeans(subset(training,select=-c(Species)),centers=input$k)
    training$clusters <- as.factor(kMeans1$cluster)
    
    # Generate the PNG
    png(outfile, width=500, height=500)
    
    qplot<- qplot(Petal.Width,Petal.Length,colour=clusters,data=training,main="iris Data Clusters")
    print(qplot)
    
    dev.off()
    
    
    # Return a list containing the filename
    list(src = outfile,
         contentType = 'image/png',
         width = 500,
         height = 500,
         alt = "This is alternate text")
  }, deleteFile = TRUE)
  
})