
#' getextent
#'
#' creates list of extents drawn in leaflet
#'
#' uses leaflet to draw polygon
#' @author Jouke <joukeverstappen@rhdhv.com>
#'
#'
#' @export
#'
#'
#' @return returns list with extent files in working directory which can be used as bbox
#'
#' @note experimental, just checking how to map a package and how to use gitlab
#'

getextent <-function(){
  polygon_draw()
  ## load just created file
  ## get extent(s) from file
  area_extent_list <- list()
  for (i in 1:length(inputIDs[["features"]])) {
    Left_south <-
      as.data.frame(inputIDs[["features"]][[i]][["geometry"]][["coordinates"]][[1]][[1]])
    colnames(Left_south) <- c("xmin", "ymin")

    Right_north <-
      as.data.frame(inputIDs[["features"]][[i]][["geometry"]][["coordinates"]][[1]][[3]])
    colnames(Right_north) <- c("xmax", "ymax")


    ## extent xmin - xmax - ymin - ymax
    ## create extent file
    extent_area <-
      extent(Left_south$xmin,
             Right_north$xmax,
             Left_south$ymin,
             Right_north$ymax)
    area_extent_list[[i]] <- (extent_area)
  }
  assign("area_extent_list",area_extent_list, envir = .GlobalEnv)
  print("shwahalala")
}

