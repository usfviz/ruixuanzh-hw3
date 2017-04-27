########## ABOUT THE DATA ###############
# Impressions: are the number of times a post from your Page is displayed
# Reach: might be less than impressions since one person can see multiple impressions. For example, if a person sees a Page update in News Feed and then sees that same update when a friend shares it that would represent a reach count of one.
# Engagement: like, comment, share
library(ggplot2)
library(shiny)
library(parcoords)
library(GGally)

# setwd("/Users/Ruixuan/Documents/01infoVisual/hw/hw3/")
facebook <- read.csv("Facebook_metrics/dataset_Facebook.csv", sep = ";")
facebook[is.na(facebook)] <- 1
heatdf <- subset(facebook, select = -c(Type))
heatdf$Post.Hour <- as.numeric(heatdf$Post.Hour)
source("helper.R")


shinyServer(function(input, output) {

## TAB 1
output$heatmap <- renderPlot({
    heat_map(heatdf, 
             "Post.Weekday", 
             "Post.Hour", 
             input$metrics, 
             "Category", 
             "Post.Month")
})

# Technique 2: Scatterplot Matrix -or- Small Multiples
output$matrices <- renderPlot({
  df <- heatdf[,7:11]
  colnames(df) <- c("Reach", "Impression", "Engaged_User", "Customers","Consumptions")
  p <- ggpairs(df, 
               # columns = c("Reach", "Impression", "Engaged User", "Customers","Consumptions"),
               lower=list(continuous='points'), 
               axisLabels='none',  
               upper=list(continuous='blank'))
  p
})

# Technique 3: Parallel Coordinates Plot
output$ParaCoor <- renderParcoords({
  df <- heatdf[,7:11]
  colnames(df) <- c("Reach", "Impression", "Engaged User", "Customers","Consumptions")
  parcoords(df, rownames = T
            , brushMode = "2D-strums"
            , reorderable = T
            , queue = F
            , color = list(
              colorBy = "cyl"
              ,colorScale = htmlwidgets::JS("d3.scale.category10()"))
  )
})

})
