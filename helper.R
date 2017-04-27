library(ggplot2)
library(viridis)

# you need to install package parcoords 
# devtools::install_github("timelyportfolio/parcoords")
library(parcoords)
# argument for heat_map(data = heatdf, x1 = "Post.Weekday",  x2 = "Post.Hour",  interest= input$metrics,  y1 = "Category", y2 =  "Post.Month")

# function to generate map 1
heat_map <- function(data, x1, x2, interest, y1, y2 ){
  p <- ggplot(data, aes_string(x1, x2, fill = interest)) +
    geom_tile(color= "white",size=0.1) + 
    scale_fill_viridis(name= interest, option = "C", alpha = 0.1, begin = 0.2)
  # p <-p + facet_grid(reformulate(y2, y1))
  p <-p + scale_y_continuous(trans = "reverse", breaks = unique(data[x2]))
  p <-p + scale_x_continuous(breaks =c(1,2,3,4,5,6,7))
  p <-p + theme_minimal(base_size = 11) 
  p <-p + labs(title= paste("Facebook", interest), x="Week Day", y="Hour")
  p <-p + theme(legend.position = "bottom")+
    theme(plot.title=element_text(size = 14))+
    theme(axis.text.y=element_blank()) +
    theme(strip.background = element_rect(colour="white"))+
    theme(plot.title=element_text(hjust=0))+
    theme(axis.ticks=element_blank())+
    theme(axis.text=element_text(face = "bold.italic", size=10))+
    theme(legend.text=element_text(size=7))
 p
}

# question 2
generate_matrix <- function(data, x1, x2, x3, x4){
  p <- ggpairs(data, 
               columns = aes_string(x1, x2, x3, x4),
               lower=list(continuous='points'), 
               axisLabels='none',  
               upper=list(continuous='blank'),
               color = "blue")
  p
}
