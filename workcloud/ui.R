fluidPage(
  # Application title
  titlePanel("Word Cloud"),
  
  sidebarLayout(
    # Sidebar with a slider and selection inputs
    sidebarPanel(
      selectInput("selection", "Choose a category",
                  choices = category_tag$category),
      actionButton("update", "Change")
    ),
    
    # Show Word Cloud
    mainPanel(
      plotOutput("plot")
    )
  )
)