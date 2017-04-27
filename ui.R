library(shiny)
library(ggplot2)
library(parcoords)
library(GGally)


# setwd("/Users/Ruixuan/Documents/01infoVisual/hw/hw3/")
facebook <- read.csv("Facebook_metrics/dataset_Facebook.csv", sep = ";")
facebook[is.na(facebook)] <- 1
heatdf <- subset(facebook, select = -c(Type))

# Define UI for random distribution application 
shinyUI(fluidPage(
  
  # 0 Application title
  headerPanel("Ruixuan Zhang: Insights of your Page"),
  
  # 0 layout a sidebar and main area
  sidebarLayout(
    
    # 1 sidebarPanel controls the input
    sidebarPanel(
      # 1.1
      # radioButtons("var", "business metrics", 
      #              list("the Number of Comment" = heatdf$comment,
      #                   "the Number of like" = heatdf$like,
      #                   "the Number of share" = heatdf$share))
      selectInput("metrics", "Metrics:", 
                  choices= c("Lifetime.Post.Total.Reach", 
                             "Lifetime.Post.Total.Impressions", 
                             "Lifetime.Engaged.Users",
                             "Lifetime.Post.Consumers", 
                             "Lifetime.Post.Consumptions")),
      hr(),
      helpText("Find the relationship bewteen posted month, weekday, hour and some business metrics")

    ),
    
    # 2 mainPanel contains the output
    mainPanel(
      tabsetPanel(
        tabPanel("Heat map", plotOutput("heatmap")), 
        tabPanel("Scatterplot Matrix", plotlyOutput("matrices")),
        # tabPanel("Scatterplot Matrix", plotlyOutput("bubble"), value=1),
        tabPanel("Parallel Coordinates Plot", parcoordsOutput("ParaCoor"))
      )
    )
  )
)
)
