getHelperText <- function() {
  div(
    h3("shinyjs usage in this app"),
    tags$ul(
      tags$li(
        "Selecting 'Bigger text' uses", code("shinyjs::addClass()"),
        "to add a CSS class to the webpage that enlarges the font"),
      tags$li(
        "Typing text inside the 'Name' field uses", code("shinyjs::enable()"),
        "to enable the submit button, and similary to disable the button",
        "when there is no input"),
      tags$li(
        "Clicking 'Show/hide advanced info' uses", code("shinyjs::onclick()"),
        "and", code("shinyjs::toggle()"), "to toggle between showing and",
        "hiding the advanced info section when the link is clicked"),
      tags$li(
        "Clicking 'Update' uses", code("shinyjs::onclick()"), "and",
        code("shinyjs::text()"), "to update the text in the timestamp when",
        "the link is clicked"),
      tags$li(
        "Clicking 'Submit' uses", code("shinyjs::info()"), "to show a",
        "message to the user")
    ),
    p("These are just a subset of the functions available in shinyjs."),
    p("This app is modified based on the final example shown at shinyjs README.html at CRAN org",
      a("Click here",
        href = "https://cran.r-project.org/web/packages/shinyjs/README.html")
    )
  )
}