#' polygon_draw
#'
#' creates list of extents drawn in leaflet
#'
#' uses leaflet to draw polygon
#' @author Jouke <joukeverstappen@rhdhv.com>
#'
#' @import raster
#' @import leaflet
#' @import shiny
#' @import leaflet.extras
#' @import stringr
#' @return returns list with extent files in working directory which can be used as bbox
#'
#' @note experimental, just checking how to map a package and how to use gitlab
#'

polygon_draw <-
function() {

  #############################
  ######### Shiny App #########
  #############################
 print("just checking")
  ## ui of only the leaflet map
  ui <- fluidPage(leafletOutput("leafmap"),
                  actionButton("ending","Done"))

  ## server
  server <- function(input, output, session) {

    output$leafmap <- renderLeaflet({
      leaflet() %>%
        addProviderTiles("Esri.WorldTopoMap")  %>%
        addDrawToolbar(editOptions = editToolbarOptions())
    })

    # Start of Drawing
    observeEvent(input$leafmap_draw_start, {
      print(str_c("Start of drawing", input$leafmap_draw_start, sep = " "))
    })

    # Stop of Drawing
    observeEvent(input$leafmap_draw_stop, {
      print(str_c("Stopped drawing", input$leafmap_draw_stop, sep = " "))
    })

    ## save info of drawn rectangle to your laptop
    observeEvent(input$leafmap_draw_all_features, {
      inputIDs      <- print(input$leafmap_draw_all_features)
      assign("inputIDs",inputIDs, envir = .GlobalEnv) ## !!  !! ## file_loc the location where info of coordinates is saved to your disk
    })

    observeEvent(input$ending, {
      stopApp()
    })
    session$onSessionEnded(function() {
      stopApp()
    })
  }

  options(shiny.launch.browser = .rs.invokeShinyWindowViewer)


  ## open shiny
  app <- shinyApp(ui, server)

  runApp(app)
  ## use draw a rectangle on the left hand side of the shiny app to draw a rectangle (multiple rectangles is possible)
}
