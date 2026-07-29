# Spatial Sampling Map Tool

This tool creates an interactive web map for visualizing sampled survey locations. First navigate to the `R` folder and open `create_map.R`. Before running the script, update the **USER SETTINGS** section with information specific to your study area. In particular, modify `geojson_file` to match the name of your uploaded GeoJSON file, update `map_lat`, `map_lon`, and `map_zoom` to set the initial map view, specify the polygon identification variable in `name_variable`, and select the variables you would like displayed in the map popup using `popup_variables`. For example:

```r
geojson_file <- "sample_locations.geojson"

map_lat <- 0
map_lon <- 0
map_zoom <- 10

name_variable <- "Name"

popup_variables <- c(
  "Name",
  "Address"
)
