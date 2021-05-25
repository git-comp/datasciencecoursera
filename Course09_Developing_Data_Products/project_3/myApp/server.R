#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    output$renderFigure <- renderPlot({

        #if (input$ZH) {
        #    cpgrawDFDisplay <- subset(cpgrawDF, cpgrawDF$geoRegion == "ZH")
        #}    
        
        cpgrawDFDisplay = NULL
        if (input$AG) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "AG"))
        }
        if (input$AI) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "AI"))
        }
        if (input$AR) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "AR"))
        }
        if (input$BE) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "BE"))
        }
        if (input$BL) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "BL"))
        }
        if (input$BS) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "BS"))
        }
        if (input$FR) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "FR"))
        }
        if (input$GE) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "GE"))
        }
        if (input$GL) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "GL"))
        }
        if (input$GR) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "GR"))
        }
        if (input$JU) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "JU"))
        }
        if (input$LU) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "LU"))
        }
        if (input$NE) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "NE"))
        }
        if (input$NW) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "NW"))
        }
        if (input$OW) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "OW"))
        }
        if (input$SO) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "SO"))
        }
        if (input$SG) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "SG"))
        }
        if (input$SH) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "SH"))
        }
        if (input$SZ) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "SZ"))
        }
        if (input$TG) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "TG"))
        }
        if (input$TI) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "TI"))
        }
        if (input$UR) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "UR"))
        }
        if (input$VD) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "VD"))
        }
        if (input$VS) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "VS"))
        }
        if (input$ZG) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "ZG"))
        }
        if (input$ZH) {
            cpgrawDFDisplay <- rbind(cpgrawDFDisplay, subset(cpgrawDF,cpgrawDF$geoRegion == "ZH"))
        }
        
        myFigure <- ggplot(cpgrawDFDisplay, aes(x = datumFactor, y=entries)) +
            geom_col(aes(fill = geoRegionFactor))
        myFigure

        
        
        
        
        
    })

    
    # initialize() loads the required data  
    initialize({
        library("data.table")
        fileUrl <- "https://www.covid19.admin.ch/api/data/20210521-abejzev6/downloads/sources-csv.zip" 
        download.file(fileUrl, destfile = paste0(getwd(), '/sources-csv.zip'), method = "curl")
        unzip("sources-csv.zip")
        
        ## parse file with weekly figures per georegion (incl. aggregated 
        ##  regions CH01..CH07, CHFL, CH)
        casesGeoRegionDT <- data.table::fread(input = ".//data//COVID19Cases_geoRegion_w.csv")
        
        ## Only select columns geoRegion, datum, entries
        cpgraw <- casesGeoRegionDT[, c("geoRegion","datum","entries")]
        
        ## remove aggregated regions CH01..CH07, CHFL, CH to avoid redundancy and double counting
        cpgraw <- cpgraw[cpgraw$geoRegion != "CH" & cpgraw$geoRegion != "CH01" & 
                             cpgraw$geoRegion != "CH02" & cpgraw$geoRegion != "CH03" & 
                             cpgraw$geoRegion != "CH04" & cpgraw$geoRegion != "CH05" & 
                             cpgraw$geoRegion != "CH06" & cpgraw$geoRegion != "CH07" & 
                             cpgraw$geoRegion != "CHFL"]
        
        ## Add factors
        cpgraw$geoRegionFactor <- as.factor(cpgraw$geoRegion)
        cpgraw$datumFactor <- as.factor(cpgraw$datum)
        
        ## Convert to data frame
        cpgrawDF <- as.data.frame(cpgraw)
        
    })
    
})
