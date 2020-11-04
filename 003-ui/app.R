# 003-ui
#
# Shiny has tools for building your user interface, so you don't have to do
# everything with HTML.
#
# Shiny offers layouts to split your app's screen into separate pieces.
#
# It also offers input controls for your user to interact with. The controls in
# this app do absolutely nothing.

library(shiny)

# This will make a static app that splits the screen into pieces
ui <- fluidPage(
    
    # You can tell Shiny to write a title this way
    titlePanel("Shiny ui+layout example"),
    
    # A sidebarLayout has a thin column on the left and a wider "body" on the 
    # right for displaying your main content.
    sidebarLayout(
        # This is the sidebar, which we use here for controls
        sidebarPanel(
            # A title
            h1("Sidebar"),
            # A verticalLayout() will simply stack elements vertically
            verticalLayout(
                # A selectInput() is a dropdown menu
                selectInput(inputId = "dropdown",
                            label = "Select a number",
                            choices = 1:5),
                # A radioButtons() is a series of toggle buttons
                radioButtons(inputId = "radio",
                             label = "Select a letter",
                             choices = letters[1:5]),
                # A sliderInput() is a control that lets the user drag left to
                # right to select a value. The example below lets the user pick
                # two values at once (a range).
                sliderInput(inputId = "slider",
                            label = "Choose a range",
                            min = 0,
                            max = 100,
                            value = c(25, 50)),
                # Just for fun, here is a dateInput() control. You can let your
                # users select a day on an interactive calendar.
                dateInput(inputId = "date",
                          label = "Select a day",
                          value = NULL)
            )
        ),
        # This is the main body of the app
        mainPanel(
            h1("Body with set-width columns"),
            # The fluidRow() lets you create columns of a set width. The width
            # units total up to 12, so that a width of 3 take 25% of the space.
            fluidRow(
                # The wellPanel() just makes a simple grey panel.
                column(wellPanel("8-wide"), width = 8),
                column(wellPanel("3-wide"), width = 3),
                column(wellPanel("1-wide"), width = 1)
            ),
            wellPanel(h1("A full-width panel"))
        )
    )
)

# Do nothing
server <- function(input, output) {
    NULL
}

# Run the application 
shinyApp(ui = ui, server = server)
