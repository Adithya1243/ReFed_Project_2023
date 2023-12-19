library(shiny)
library(networkD3)

# Define UI
ui <- fluidPage(
  titlePanel("Sankey Diagram for Farm Produce"),
  sidebarLayout(
    sidebarPanel(
      numericInput("numberInput", "Enter a Number for Farm Produce:", value = 1100347356.94),
      numericInput("percentToManufacturing", "Farm to Manufacturing (%):", value = 50),
      numericInput("percentToFoodService", "Farm to Food Service (%):", value = 20),
      numericInput("percentToRetail", "Farm to Retail (%):", value = 15),
      numericInput("percentToResidential", "Farm to Residential (%):", value = 10),
      numericInput("percentSurplus", "Farm to Surplus (%):", value = 5),
      hr(),
      numericInput("percentManufacturingToFoodService", "Manufacturing to Food Service (%):", value = 40),
      numericInput("percentManufacturingToRetail", "Manufacturing to Retail (%):", value = 30),
      numericInput("percentManufacturingToResidential", "Manufacturing to Residential (%):", value = 20),
      numericInput("percentManufacturingSurplus", "Manufacturing to Surplus (%):", value = 10),
      hr(),
      numericInput("percentFoodServiceToResidential", "Food Service to Residential (%):", value = 80),
      numericInput("percentFoodServiceSurplus", "Food Service to Surplus (%):", value = 20),
      hr(),
      numericInput("percentRetailToResidential", "Retail to Residential (%):", value = 70),
      numericInput("percentRetailSurplus", "Retail to Surplus (%):", value = 30)
    ),
    mainPanel(
      sankeyNetworkOutput("sankeyDiagram")
    )
  )
)

# Define server logic
server <- function(input, output) {
  calculate_links <- function(user_input, percent_to_manufacturing, percent_to_food_service, percent_to_retail, percent_to_residential, percent_surplus, percent_manufacturing_to_food_service, percent_manufacturing_to_retail, percent_manufacturing_to_residential, percent_manufacturing_surplus, percent_food_service_to_residential, percent_food_service_surplus, percent_retail_to_residential, percent_retail_surplus) {
    # Initial distribution from the Farm stage
    farm_to_manufacturing <- user_input * percent_to_manufacturing / 100
    farm_to_food_service <- user_input * percent_to_food_service / 100
    farm_to_retail <- user_input * percent_to_retail / 100
    farm_to_residential <- user_input * percent_to_residential / 100
    farm_surplus <- user_input * percent_surplus / 100
    
    # Distribution from the Manufacturing stage
    manufacturing_to_food_service <- farm_to_manufacturing * percent_manufacturing_to_food_service / 100
    manufacturing_to_retail <- farm_to_manufacturing * percent_manufacturing_to_retail / 100
    manufacturing_to_residential <- farm_to_manufacturing * percent_manufacturing_to_residential / 100
    manufacturing_surplus <- farm_to_manufacturing * percent_manufacturing_surplus / 100
    
    # Distribution from Food Service
    food_service_to_residential <- farm_to_food_service * percent_food_service_to_residential / 100
    food_service_surplus <- farm_to_food_service * percent_food_service_surplus / 100
    
    # Distribution from Retail
    retail_to_residential <- farm_to_retail * percent_retail_to_residential / 100
    retail_surplus <- farm_to_retail * percent_retail_surplus / 100
    
    # Creating the links data frame
    links_data <- data.frame(
      source = c('Farm', 'Farm', 'Farm', 'Farm', 'Farm',
                 'Manufacturing', 'Manufacturing', 'Manufacturing', 'Manufacturing',
                 'Food Service', 'Food Service',
                 'Retail', 'Retail'),
      target = c('Manufacturing', 'Food Service', 'Retail', 'Residential', 'Surplus',
                 'Food Service', 'Retail', 'Residential', 'Surplus',
                 'Residential', 'Surplus',
                 'Residential', 'Surplus'),
      value = c(farm_to_manufacturing, farm_to_food_service, farm_to_retail, farm_to_residential, farm_surplus,
                manufacturing_to_food_service, manufacturing_to_retail, manufacturing_to_residential, manufacturing_surplus,
                food_service_to_residential, food_service_surplus,
                retail_to_residential, retail_surplus),
      IDsource = match(c('Farm', 'Farm', 'Farm', 'Farm', 'Farm',
                         'Manufacturing', 'Manufacturing', 'Manufacturing', 'Manufacturing',
                         'Food Service', 'Food Service',
                         'Retail', 'Retail'), 
                       unique(c('Farm', 'Manufacturing', 'Food Service', 'Retail')))-1,
      IDtarget = match(c('Manufacturing', 'Food Service', 'Retail', 'Residential', 'Surplus',
                         'Food Service', 'Retail', 'Residential', 'Surplus',
                         'Residential', 'Surplus',
                         'Residential', 'Surplus'),
                       unique(c('Farm', 'Manufacturing', 'Food Service', 'Retail', 'Residential', 'Surplus')))-1
    )
    
    list(nodes = data.frame(name = unique(c('Farm', 'Manufacturing', 'Food Service', 'Retail', 'Residential', 'Surplus'))),
         links = links_data)
  }
  
  output$sankeyDiagram <- renderSankeyNetwork({
    data <- calculate_links(input$numberInput, 
                            input$percentToManufacturing, 
                            input$percentToFoodService, 
                            input$percentToRetail, 
                            input$percentToResidential, 
                            input$percentSurplus,
                            input$percentManufacturingToFoodService,
                            input$percentManufacturingToRetail,
                            input$percentManufacturingToResidential,
                            input$percentManufacturingSurplus,
                            input$percentFoodServiceToResidential,
                            input$percentFoodServiceSurplus,
                            input$percentRetailToResidential,
                            input$percentRetailSurplus)
    sankeyNetwork(Links = data$links, Nodes = data$nodes,
                  Source = "IDsource", Target = "IDtarget",
                  Value = "value", NodeID = "name",
                  units = "CWT", fontSize = 12, nodeWidth = 30)
  })
  

}

# Run the application
shinyApp(ui = ui, server = server)
