# user interface ----
ui <- navbarPage(
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tabPanel ----
  tabPanel(title = "About this page",
           
           # intro text fluidRow ----
           fluidRow(
             
             column(1),
             column(12, includeMarkdown("text/about.md")),
             column(1)
             
           ), # END intro text fluidRow ----
           
           hr(),
           
           includeMarkdown("text/footer.md")
           
  ), # END (Page 1) intro tabPanel
  
  # (Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tabs for data viz ----
           tabsetPanel(
             
             # trout tabPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type pickerinput ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel types:",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE),
                          
                          # section checkboxGroupButtons
                          checkboxGroupButtons(inputId = "section_input",
                                               label = "Select a sampling sections:",
                                               choices = c("clear cut forest", "old growth forest"),
                                               selected = c("clear cut forest", "old growth forest"),
                                               individual = FALSE, justified = TRUE, size = "sm", 
                                               checkIcon = list(yes = icon("check"),
                                                                no = icon("xmark")))
                          
                        ), # END trout sidebarPanel
                        
                        # trout mainPanel ----
                        mainPanel(
                          
                          # trout scatter plot output ----
                          plotOutput(outputId = "trout_scatterplot_output") %>% 
                            withSpinner(color = "magenta", type = 1)
                  
                        ) # END trout mainPanel
                        
                      ) # END trout sidebarLayout
                      
             ), # END trout tabPanel
             
             # penguin tabPanel ----
             tabPanel(title = "Penguin",
                      
                      # trout sidebarLayout ----
                      sidebarLayout(
                        
                        # penguin sidebarPanel ----
                        sidebarPanel(
                          
                          # island pickerInput ----
                          pickerInput(inputId = "penguin_island_input",
                                      label = "Select islands:",
                                      choices = unique(penguins$island),
                                      selected = unique(penguins$island),
                                      options = pickerOptions(actionsBox = TRUE),
                                      multiple = TRUE),
                          
                          # bin number sliderInput
                          sliderInput(inputId = "bin_number_input",
                                      label = "Select number of bins",
                                      value = 25,
                                      min = 1,
                                      max = 50)
                          
                        ), # END penguin sidebarPanel
                        
                        # penguin mainPanel ----
                        mainPanel(
                          
                          # penguin scatter plot output ----
                          plotOutput(outputId = "penguin_histogram_output") %>% 
                            
                            # add a loading bar
                            withSpinner(color = "seagreen", type = 1)
                          
                        ) # END penguin mainPanel
                        
                      ) # END penguin sidebarLayout
                      
             ) # END penguin tabPanel
             
           ) # END tabsetPanel
           
  ) # END (Page 2) data viz tabPanel
  
) # END navbarPage