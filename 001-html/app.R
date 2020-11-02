# This is an example of what a minimal Shiny app is. It does nothing. It only
# shows a bit of HTML on the screen.

# Define a UI with only a series of HTML tags
ui <- shiny::fluidPage(
    shiny::tags$h1("Title"),
    shiny::tags$h2("Subtitle"),
    shiny::tags$p("A paragraph of text."),
    shiny::tags$hr(),
    shiny::tags$code("mtcars %>% View()")
)

# Use an empty server since the app computes nothing
server <- function(input, output) {
    NULL
}

# Run the application 
shinyApp(ui = ui, server = server)
