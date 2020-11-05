# 004-ggplot
#
# In Shiny, you have inputs and outputs. Inputs are defined in the UI and the
# outputs in the server.
# 
# Below is an example of how an input can be accessed (like a variable) in the
# server. You can also see how an output created in the server can be displayed
# in the ui.

library(shiny)
library(ggplot2)

# This is a simple with a dropdown menu that lets you choose the iris species to
# highlight
ui <- fluidPage(
    
    # Application title
    titlePanel("Iris display app"),
    
    # Make a webpage layout with a sidebar
    sidebarLayout(
        sidebarPanel(
            # Create a dropdown control
            # The user will have the choice of setosa, versicolor and virginica,
            # and the Shiny server will retrieve the selection with
            # input$species_select.
            selectInput(inputId = "species_select",
                        label = "Select species",
                        choices = c("setosa", "versicolor", "virginica"),
                        multiple = FALSE)
        ),
        
        # Render ggplot graphic
        # Shiny will look for the plot in the output$scatter_plot
        mainPanel(
            plotOutput(outputId = "scatter_plot")
        )
    )
)

# The server simply looks at the user input and returns the appropriate plot.
server <- function(input, output) {
    # This is a "reactive value". It's a dynamic value that gets recalculated.
    #
    # Shiny will automatically re-run the renderPlot function if it detects any
    # change in the variables that the plot uses. The only changing variable
    # here is input$species_select.
    #
    # If the iris dataframe were to change while Shiny is running, the
    # renderPlot() will re-run.
    #
    # Note: you can isolate() a variable to have Shiny ignore it.
    output$scatter_plot <- renderPlot(
        # This expression will be recalculated if Shiny detects changes in its
        # variables
        expr = {
            ggplot(iris, aes(x = Sepal.Length,
                             y = Sepal.Width,
                             color = Species,
                             shape = Species)) +
                geom_point(size = ifelse(iris$Species == input$species_select,
                                         5,
                                         3)) +
                guides(size = FALSE)
        }
    )
}

# Run the application 
shinyApp(ui = ui, server = server)
