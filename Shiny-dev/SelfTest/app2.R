# Using shinyjs with navbarPage layout
# https://cran.r-project.org/web/packages/shinyjs/README.html
library(shiny)
library(shinyjs)

ui <- tagList(
  useShinyjs(),
  navbarPage(
    "shinyjs with navbarPage",
    tabPanel("tab1",
             actionButton("button", "Click me"),
             div(id = "hello", "Hello!")),
    tabPanel("tab2",
             actionButton("button2", "Click me"),
             div(id = "hello2", "Hello2!"))
  )
)

server <- function(input, output, session) {
  observeEvent(input$button, {
    toggle("hello")
  })
  observeEvent(input$button2, {
    toggle("hello2")
  })
}

shinyApp(ui, server)