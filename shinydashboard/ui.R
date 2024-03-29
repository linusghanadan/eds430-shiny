# dashboard header ----
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Monitoring",
  titleWidth = 400
)

# dashboard sidebar ----
sidebar <- dashboardSidebar(
  
  # sidebar ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")),
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
    
  ) # END sidebarMenu
  
)

# dashboard body ----
body <- dashboardBody(
  
  fresh::use_theme("dashboard-fresh-theme.css"),
  
  # tabItems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "welcome",
            
            # left-hand column ----
            column(width = 6,
                   
                   # background info box ----
                   box(width = NULL,
                       
                       title = tagList(icon("water"),
                                       strong("Monotoring Fish Creek Watershed")),
                       includeMarkdown("text/intro.md"),
                       tags$img(src = "FishCreekWatershedSiteMap_2020.jpeg",
                                alt = "A map of Northern Alaska, showing Fish Creek Watershed",
                                style = "max-width: 100%;"),
                       tags$h6(tags$em("Map Source:", tags$a(href = "http://www.fishcreekwatershed.org/",
                                                             "FCWO")),
                               style = "text-align: center;")
                       
                   ) # END background info box
                   
            ), # END left-hand column
            
            # right-hand column ----
            column(width = 6,
                   
                   # first fluid row ----
                   fluidRow(
                     
                     # citation box ----
                     box(width = NULL,
                         
                         title = strong("Citation"),
                         includeMarkdown("text/citation.md")
                         
                     ) # END citation box
                     
                   ), # END first fluidRow
                   
                   # second fluidRow ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         title = strong("Disclaimer"),
                         includeMarkdown("text/disclaimer.md")
                         
                     ) # END disclaimer box
                     
                     
                   ) # END second fluidRow
                   
            ) # END right-hand column
            
    ), # END welcome tabItem 
    
    # dashboard tabItem ----
    tabItem(tabName = "dashboard",
            
            # fluidRow ----
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                  title = tags$strong("Adjust lake parameter ranges:"),
                  
                  # sliderInputs ----
                  sliderInput(inputId = "elevation_slider_input",
                              label = "Elevation (meters above SL)",
                              min = min(lake_data$Elevation),
                              max = max(lake_data$Elevation),
                              value = c(min(lake_data$Elevation),
                                        max(lake_data$Elevation))),
                  # sliderInputs ----
                  sliderInput(inputId = "avg_depth_slider_input",
                              label = "Avg Depth (meters)",
                              min = min(lake_data$AvgDepth),
                              max = max(lake_data$AvgDepth),
                              value = c(min(lake_data$AvgDepth),
                                        max(lake_data$AvgDepth))),
                  # sliderInputs ----
                  sliderInput(inputId = "avg_temp_slider_input",
                              label = "Avg Lake Bed Temperature (ºC)",
                              min = min(lake_data$AvgTemp),
                              max = max(lake_data$AvgTemp),
                              value = c(min(lake_data$AvgTemp),
                                        max(lake_data$AvgTemp)))
                  
              ), # END input box
              
              # map box ----
              box(width = 8,
                  
                  title = strong("Monitoring lakes within Fish Creek Watershed:"),
                  
                  # leaflet output ----
                  leafletOutput(outputId = "lake_map_output") %>% 
                    withSpinner(type = 1, color = "cornflowerblue")
                  
              ) # END map box
              
            ) # END fluidRow
            
    ) # END dashboard tabItem
    
  ) # END tabItems
  
)  
  # combine all into a dashboard page ----
  dashboardPage(header, sidebar, body)
  