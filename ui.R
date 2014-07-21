library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("Clustering iris Data"),
  sidebarPanel(
    sliderInput("k", "Number of clusters:",
                min = 1, max = 5,  value = 3)
  ),
  mainPanel(
    # Use imageOutput to place the image on the page
    imageOutput("myImage")
  )
))