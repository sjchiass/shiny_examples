# 002-styling
#
# This is a modification of the first example. CSS styling is added to the app
# so that text is centered on the screen.

library(shiny)

# Define a UI with HTML tags that include a styling entry in the page's <head>
ui <- fluidPage(
    # This will add something to the page's <head>
    tags$head(
        # This will add a <style> tag that affects <p> tags in the <body>
        tags$style("p {text-align : center;}")
    ),
    tags$h1("Title"),
    tags$h2("Subtitle"),
    # This <p> tag will now be styled differently
    tags$p("A paragraph of text that is now centered!"),
    tags$hr(),
    tags$code("mtcars %>% View()")
)

# Use an empty server since the app computes nothing
server <- function(input, output) {
    NULL
}

# Run the application 
shinyApp(ui = ui, server = server)
