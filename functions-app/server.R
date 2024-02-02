server <- function(input, output) {
  
  # Use custom built function to build scatter plot
  output$penguin_scatterplot_output <- build_penguin_scatterplot(input)
  
  
  # filter penguin species (histogram) ----
  filtered_spp_histogram_df <- reactive ({
    
    penguins |>
      filter(species %in% input$penguinSpp_histogram_input)
    
  })
  
  # render the histogram output ----
  output$penguin_histogram_output <- renderPlot({
    
    ggplot(na.omit(filtered_spp_histogram_df()),
           aes(x = flipper_length_mm, fill = species)) +
      geom_histogram(alpha = 0.5, position = "identity") +
      scale_fill_manual(values = c("Adelie" = "#FEA346", "Chinstrap" = "#B251F1", "Gentoo" = "#4BA4A4")) +
      labs(x = "Flipper length (mm)", y = "Frequency",
           fill = "Penguin species")
    
  })
  
} # END server