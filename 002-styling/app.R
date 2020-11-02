# This is a modification of the first example. CSS styling is added to the app
# so that text is centered on the screen.

# Define a UI with HTML tags that include a styling entry in the page's <head>
ui <- shiny::fluidPage(
    # This will add something to the page's <head>
    shiny::tags$head(
        # This will add a <style> tag that affects <p> tags in the <body>
        shiny::tags$style("p {text-align : center;}")
    ),
    shiny::tags$h1("Title"),
    shiny::tags$h2("Subtitle"),
    # This <p> tag will now be styled differently
    shiny::tags$p("A paragraph of text that is now centered!"),
    shiny::tags$hr(),
    shiny::tags$code("mtcars %>% View()")
)

# Use an empty server since the app computes nothing
server <- function(input, output) {
    NULL
}

# Run the application 
shinyApp(ui = ui, server = server)
