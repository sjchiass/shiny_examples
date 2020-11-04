# 001-html
#
# This is an example of what a minimal Shiny app is. It does nothing. It only
# shows a bit of HTML on the screen.

library(shiny)

# Define a UI with only a series of HTML tags
ui <- fluidPage(
    tags$h1("Title"),
    tags$h2("Subtitle"),
    tags$p("A paragraph of text."),
    tags$hr(),
    tags$code("mtcars %>% View()")
)

# Use an empty server since the app computes nothing
server <- function(input, output) {
    NULL
}

# Run the application 
shinyApp(ui = ui, server = server)
