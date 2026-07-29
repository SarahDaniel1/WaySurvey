# WaySurvey

WaySurvey is a customizable interactive web map for visualizing and managing study sites, such as selected survey locations. The map allows researchers to easily visualize all study sites on a map and easily navigate to them. To use WaySurvey, researchers upload geographic data containing predefined site boundaries together with associated site attributes. The tool then generates an interactive field map that enables researchers to visualize all study sites, navigate to individual sites, view its boundaries and a summary of the site's information. An example of the final field map can be viewed [here](https://sarahdaniel1.github.io/Nairobi_survey_locations/). This map was used to help enumerators in Nairobi navigate sampled study sites and collect household survey data. The instructions below explain how to create a similar interactive map for your own research.

## Instructions

### 1. Upload GeoJSON file to your GitHub repository

Your sampled locations should be imported as a GeoJSON file containing a geometry column that defines the boundaries of each sampled site, as well as columns containing associated attributes (e.g., location name/location ID and address). Examples of sites include census enumeration areas (EAs), census blocks, villages, or any other geographic units within which you will be collecting data.

### 2. Navigate to the `R` folder and open `create_map.R`

### 3. Edit the USER SETTINGS section

Before running the script, update the **USER SETTINGS** section with information specific to your study area. In particular, modify `geojson_file` to match the name of your uploaded GeoJSON file, update `map_lat`, `map_lon`, and `map_zoom` to set the initial map view, specify the polygon identification variable in `name_variable`, and select the variables you would like displayed in the map popup using `popup_variables`. These variables can include information such as the address of the starting sampling point, stratum, assigned enumerator, or other relevant information.

For example:

```r
geojson_file <- "Your_GeoJSON_file.geojson"

# Map starting location
map_lat <- 0
map_lon <- 0
map_zoom <- 10

# Column used to identify sampled locations
name_variable <- "Name"

# Variables displayed in popup
# If "Address" is included, it will automatically become a Google Maps hyperlink
popup_variables <- c(
  "Name",
  "Address"
  # Add additional variables here:
  # "Stratum",
  # "Enumerator"
)
```


4. Run the entire script

After making these changes, run the entire R script. The script will generate an index.html file containing the map.

5. Upload the index.html and GeoJSON files

To view the map, upload both the generated index.html file and your GeoJSON file to the same GitHub repository. Then use GitHub Pages to host the interactive map and generate a shareable link for enumerators.
