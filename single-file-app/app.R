# load packages ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)
library(bslib)

# Applies theme background color to plot
thematic::thematic_shiny()

# user interface ----
ui <- fluidPage(
  
  theme = bs_theme(
    
    bg = "#a36f6f",
    fg = "#FDF7f7",
    primary = "#483132",
    base_font = font_google("Pacifico")
    
  ),
  
  # app title ----
  tags$h1("My App Title"),
  
  # app subtitle (bolded) ----
  h4(strong("Exploring Antarctic Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g):",
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output ----
  plotOutput(outputId = "bodyMass_scatterplot_output"),
  
  # year check box input ----
  checkboxGroupInput(inputId = "year_input",
                     label = "Select years:",
                     choices = unique(penguins$year),
                     selected = c("2007", "2008")),
  
  # DT output ----
  DT::dataTableOutput(outputId = "penguin_DT_output")
  
)

# server ----
server <- function(input, output) {
  
  # filter body masses ----
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
    
  })
  
  # render penguin scatter plot ----
  output$bodyMass_scatterplot_output <- renderPlot({
    
    # add ggplot code
    ggplot(na.omit(body_mass_df()),
           aes(x = flipper_length_mm, y = bill_length_mm,
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", "Chinstrap" =  "purple", "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie" = 19, "Chinstrap" = 17, "Gentoo" = 15)) +
      labs(x = "Flipper length (mm)",
           y = "Bill length (mm)",
           color = "Penguin species",
           shape = "Penguin species") +
      theme_minimal() +
      theme(legend.position = c(0.85, 0.2),
            legend.background = element_rect(color = "white"))
  })
  
  # filter year
  year_df <- reactive({
    penguins %>% 
      filter(year %in% c(input$year_input))
  })
  
  # render DT table ----
  output$penguin_DT_output <- DT::renderDataTable({
    
    # add data table code
    DT::datatable(year_df())
  })
}

# combine UI & server into app ----
shinyApp(ui = ui, server = server)
