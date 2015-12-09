#Using shinyjs in Shiny Dashboards
# https://cran.r-project.org/web/packages/shinyjs/README.html
library(shiny)
library(shinydashboard)
library(shinyjs)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(),
  dashboardBody(
    useShinyjs(),
    actionButton("button", "Click me"),
    div(id = "hello", "Hello!")
  )
)

server <- function(input, output) {
  observeEvent(input$button, {
    toggle("hello")
  })
}

shinyApp(ui, server)