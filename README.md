# WaySurvey

WaySurvey is a customizable interactive web map for visualizing and managing study areas, such as sampled survey locations. Researchers can upload geographic data containing predefined study areas and generate an interactive field map for fieldwork coordination and documentation. The map allows researchers to view all sampled areas using the location search dropdown, visualize survey sites, and click on individual locations to display their boundaries and a summary of relevant information for each sampled site. This information can include the address of the Starting Sampling Point (SSP), assigned enumerator, stratum, or other study area attributes.

## Instructions

### 1. Upload GeoJSON file to your GitHub repository

Your sampled locations should be imported as a GeoJSON file containing a geometry column that defines the boundaries of each sampled site, as well as columns with associated attributes (e.g., location name/location ID, address).

### 2. Navigate to the `R` folder and open `create_map.R`

### 3. Edit the USER SETTINGS section

Before running the script, update the **USER SETTINGS** section with information specific to your study area. In particular, modify `geojson_file` to match the name of your uploaded GeoJSON file, update `map_lat`, `map_lon`, and `map_zoom` to set the initial map view, specify the polygon identification variable in `name_variable`, and select the variables you would like displayed in the map popup using `popup_variables`. These variables can include information such as the address of the starting sampling point, stratum, assigned enumerator, or other relevant information.

For example:

```r
geojson_file <- "sample_locations.geojson"

map_lat <- 0
map_lon <- 0
map_zoom <- 10

name_variable <- "Name"

popup_variables <- c(
  "Name",
  "Starting Sampling Point Address"
)
```
4. Run the entire script

After making these changes, run the entire R script. The script will generate an index.html file containing the map.

5. Upload the index.html and GeoJSON files

To view the map, upload both the generated index.html file and your GeoJSON file to the same GitHub repository. Then use GitHub Pages to host the interactive map and generate a shareable link for enumerators.
