# 005-datatable
#
# In Shiny, you have inputs and outputs. Inputs are defined in the UI and the
# outputs in the server.
# 
# Below is an example of how an input can be accessed (like a variable) in the
# server. You can also see how an output created in the server can be displayed
# in the ui.

library(shiny)

# This is a simple with a dropdown menu that lets you choose the dataframe to
# display
ui <- fluidPage(
    
    # Application title
    titlePanel("Table display app"),
    
    # Make a webpage layout with a sidebar
    sidebarLayout(
        sidebarPanel(
            # Create a dropdown control
            # R will identify it as input$df and the dropdown will offer the
            # choice of quakes, iris and mtcars
            selectInput(inputId = "df",
                        label = "Select dataset",
                        choices = c("quakes", "iris", "mtcars"),
                        multiple = FALSE)
        ),
        
        # Render an interactive table
        # The ui will look for the output$datatable variable in the server
        mainPanel(
            uiOutput(outputId = "df_title"),
            dataTableOutput(outputId = "datatable")
        )
    )
)

# The server simply looks at the user input and returns the appropriate table.
server <- function(input, output) {
    # A simple dynamic title
    # UI elements can be reactive
    output$df_title <- renderUI(
        h1(sprintf("%s dataset", input$df))
    )
    
    # This is a "reactive value". It's a dynamic value that gets recalculated.
    #
    # Shiny will automatically re-run the function if it detects any change in
    # its inputs. This will give a new value of output$datatable.
    #
    # Whenever input$df changes, Shiny will recalculate output$datatable.
    #
    # Note: you can isolate() a variable to have Shiny ignore it.
    output$datatable <- renderDataTable(
        # This expression will be recalculated in reaction to a change in
        # input$df
        expr = {
            # The code below is a normal R if-then statement
            # You can use normal R code in reactive expressions
            if (input$df == "quakes") {
                quakes
            } else if (input$df == "iris") {
                iris
            } else if (input$df == "mtcars") {
                mtcars
            } else {
                data.frame()
            }
        },
        # The renderDataTable() function accepts options. The pageLength option
        # is just here to make the app fit on the page.
        options = list(pageLength = 10))
}

# Run the application 
shinyApp(ui = ui, server = server)
