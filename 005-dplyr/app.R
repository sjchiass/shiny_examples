# 005-dplyr
#
# Shiny inputs and outputs can be reactive, but reactive values can also be just
# R objects. The Shiny server can have reactive vectors and dataframes that it
# automatically updates when necessary.
#
# The app uses some dplyr code to generate some reactive values that are used
# for the inputs and outputs.
#
# When you start the app, you'll see the mtcars dataset on the right. Using the
# dropdowns, you can select a column to filter by and Shiny will give you a list
# of values to filter for. A third dropdown gives you the choice of a summary
# function to apply in the second tab.
#
# It's important to note that Shiny inputs usually return character vectors, so
# you may have to use different dplyr functions than you're used to.

library(shiny)
library(dplyr)

# Define UI for application that draws a histogram
ui <- fluidPage(
    
    # Application title
    titlePanel("mtcars summarizer"),
    
    # The sidebar has three dropdown menus, one of which is dynamic
    sidebarLayout(
        sidebarPanel(
            selectInput(inputId = "column_selection",
                        label = "Select a column to filter by",
                        choices = names(mtcars),
                        multiple = FALSE),
            # uiOutput() will retrieve an output from the Shiny server and use
            # it as a ui element
            uiOutput("filter_selection"),
            selectInput(inputId = "summarize_function",
                        label = "Summary function",
                        choices = c("sum", "mean", "min", "max", "length"))
        ),
        
        # The tabsetPanel() houses tabPanel() that will be tabs that the user
        # can click on
        mainPanel(
            tabsetPanel(
                tabPanel(title = "Filtered dataframe",
                         dataTableOutput(outputId = "filtered_data_table")
                ),
                tabPanel(title = "Summarized dataframe",
                         dataTableOutput(outputId = "summarized_data_table")
                )
            )
        )
    )
)

# The server is ready to recalculate values, ui elements, and tables.
server <- function(input, output) {
    #
    # Reactive values ----------------------------------------------------------
    #
    # This will select distinct values of `input$column_selection` and return
    # them sorted
    filter_choices <- reactive(
        mtcars %>%
            select_at(input$column_selection) %>%
            distinct() %>%
            arrange_at(input$column_selection) %>%
            pull()
    )
    
    # Given a value in input$filter_value, this reactive will filter mtcars for
    # `input$column_selection` == `input$filter_value`
    filtered_data <- reactive(
        {
            # Only react if there is a filter value
            req(input$filter_value)
            
            # EVERYTHING is a special value that just returns the full mtcars
            if (input$filter_value == "EVERYTHING") return(mtcars)
            
            # Otherwise, have dplyr filter
            mtcars %>%
                filter_at(input$column_selection,
                          any_vars(. == as.numeric(input$filter_value)))
        }
    )
    
    # Given the users's choice of a summarization function, this will return
    # the appropriate R function.
    #
    # You may be tempted to just use `get(input$summarize_function)` but a
    # clever user could trick your app into using an arbitrary function.
    summary_function <- reactive(
        {
            if (input$summarize_function == "sum") {
                sum
            } else if (input$summarize_function == "mean") {
                mean
            } else if (input$summarize_function == "min") {
                min
            } else if (input$summarize_function == "max") {
                max
            } else if (input$summarize_function == "length") {
                length
            } else {
                length
            }
        }
    )
    
    # Given a column and a summary function, this reactive value will group
    # mtcars, summarize, and then ungroup it so that it can be displayed.
    summarized_data <- reactive(
        {
            req(filtered_data)
            
            filtered_data() %>%
                group_by_at(input$column_selection) %>%
                summarise_all(summary_function()) %>%
                ungroup()
        }
    )
    #
    # Outputs ------------------------------------------------------------------
    #
    # renderUI() is a very useful function. Giving it reactive values will
    # create a dynamic interface element. Here it is used to make a dropdown
    # menu dynamic.
    output$filter_selection <- renderUI(
        {
            selectInput(inputId = "filter_value",
                        label = sprintf("Select a value to %s filter for",
                                        input$column_selection),
                        choices = c("EVERYTHING", filter_choices()))
        }
    )
    
    # These two outputs will render the two reactive dataframes above.
    output$filtered_data_table <- renderDataTable(filtered_data(),
                                                  options = list(pageLength = 10))
    
    output$summarized_data_table <- renderDataTable(summarized_data(),
                                                    options = list(pageLength = 10))
}

# Run the application 
shinyApp(ui = ui, server = server)
