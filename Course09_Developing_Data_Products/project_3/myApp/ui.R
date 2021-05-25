#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# The app loads the official COVID-19 cases data from Switzerland as 
# per May 21, 2021, and provides a stacked histogram per calendar week
# and Canton (equivalent to States in the U.S.). The individual Cantons
# can be selected with checkboxes. Some checkboxes have been pre-selected
# to allow an interactive demo.
#

# PLEASE NOTE: 
# initialize() on the server.R downloads the data and prepares it for 
# presentation. This may take up to a minute depending on your internet 
# connection (11Mb), so please be patient if the plot does not immediately 
# show after start!
# 

library(shiny)
library(ggplot2)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("COVID-19 cases in Switzerland"),
    div("The app loads the official COVID-19 cases data from Switzerland as 
    per May 21, 2021, and provides a stacked histogram per calendar week 
    and Canton (equivalent to States in the U.S.). The individual Cantons 
    can be selected with checkboxes. Some checkboxes have been pre-selected 
        to allow an interactive demo."),
    br(),
    div("PLEASE NOTE: initialize() on the server.R downloads the data and 
    prepares it for presentation. This may take up to a minute depending on 
    your internet connection (11Mb), so please be patient if the plot does 
    not immediately show after start!"),
    br(),
    code("Please wait until plot is loaded, it takes a minute or two"),
    br(),
    br(),

    # Sidebar with two slider inputs for the date range selection
    sidebarLayout(
        sidebarPanel(
            checkboxInput("AG", label = "Aargau", value = TRUE),
            checkboxInput("AI", label = "Appenzell Innerrhoden", value = FALSE),
            checkboxInput("AR", label = "Appenzell Ausserrhoden", value = FALSE),
            checkboxInput("BE", label = "Bern", value = TRUE),
            checkboxInput("BL", label = "Basel Landschaft", value = FALSE),
            checkboxInput("BS", label = "Basel Stadt", value = FALSE),
            checkboxInput("FR", label = "Fribourg", value = TRUE),
            checkboxInput("GE", label = "Geneva", value = TRUE),
            checkboxInput("GL", label = "Glarus", value = TRUE),
            checkboxInput("GR", label = "Graubünden", value = TRUE),
            checkboxInput("JU", label = "Jura", value = TRUE),
            checkboxInput("LU", label = "Luzern", value = TRUE),
            checkboxInput("NE", label = "Neuchâtel", value = FALSE),
            checkboxInput("NW", label = "Nidwalden", value = TRUE),
            checkboxInput("OW", label = "Obwalden", value = FALSE),
            checkboxInput("SO", label = "Solothurn", value = TRUE),
            checkboxInput("SG", label = "St. Gallen", value = FALSE),
            checkboxInput("SH", label = "Schaffhausen", value = TRUE),
            checkboxInput("SZ", label = "Schwyz", value = FALSE),
            checkboxInput("TG", label = "Thurgau", value = TRUE),
            checkboxInput("TI", label = "Ticino", value = FALSE),
            checkboxInput("UR", label = "Uri", value = TRUE),
            checkboxInput("VD", label = "Vaud", value = FALSE),
            checkboxInput("VS", label = "Valais", value = FALSE),
            checkboxInput("ZG", label = "Zug", value = TRUE),
            checkboxInput("ZH", label = "Zurich", value = TRUE)
        ),

        # Show a plot of the generated distribution
        mainPanel(
            plotOutput("renderFigure")
        )
    )
))
