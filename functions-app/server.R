server <- function(input, output) {
  
  # Use custom built function to build scatter plot
  output$penguin_scatterplot_output <- build_penguin_scatterplot(input)
  
  # Use custom built function to build histogram
  output$penguin_histogram_output <- build_penguin_histogram(input) 

  
} # END server