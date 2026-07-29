# ==========================================================
# Spatial Sampling Map Tool
# Generates an interactive Leaflet map from sampled polygons
# ==========================================================


# ----------------------------
# USER SETTINGS
# ----------------------------

# GeoJSON file containing sampled polygons
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



# ----------------------------
# CREATE POPUP CODE
# ----------------------------


popup_code <- paste(
  sapply(
    popup_variables,
    function(x) {
      
      if (x == "Address") {
        
        paste0(
          "<b>Address:</b> ",
          "${feat.properties.Address ? ",
          "`<a href=\"https://www.google.com/maps/search/?api=1&query=${encodeURIComponent(feat.properties.Address)}\" target=\"_blank\">${feat.properties.Address}</a>`",
          " : 'N/A'}"
        )
        
      } else {
        
        paste0(
          "<b>",
          x,
          ":</b> ${feat.properties.",
          x,
          " || 'N/A'}"
        )
        
      }
      
    }
  ),
  collapse = "<br>"
)



# ----------------------------
# CREATE HTML MAP
# ----------------------------


index_simple <- paste0('

<!DOCTYPE html>
<html>

<head>

<title>Spatial Sampling Map</title>

<meta name="viewport" content="width=device-width">

<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>


<style>

body {
margin:0;
font-family:Arial;
}


#controls {

position:absolute;
top:10px;
left:10px;
z-index:1000;

background:white;
padding:20px;

border-radius:12px;

box-shadow:0 4px 20px rgba(0,0,0,0.2);

}


select {

padding:10px;

font-size:16px;

width:250px;

}


#map {

height:100vh;

}


.tooltip {

background:rgba(255,152,0,0.9);

color:white;

border:none;

}


</style>


</head>


<body>



<div id="controls">

<label>

Select Location:

<select id="location-select" onchange="showSelectedLocation()">

<option value="">
All Sampled Locations
</option>

</select>


</label>

</div>



<div id="map"></div>



<script>


var map = L.map("map").setView([',
map_lat,
',
',
map_lon,
',
',
map_zoom,
']);


L.tileLayer(

"https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",

{

maxZoom:19

}

).addTo(map);




var allData;

var currentLayer;




fetch("',
geojson_file,
'")

.then(r => r.json())

.then(data => {


allData=data;


var polygons=data.features.filter(f =>

f.geometry.type==="Polygon" ||

f.geometry.type==="MultiPolygon"

);



currentLayer=L.geoJSON(

{

type:"FeatureCollection",

features:polygons

},

{


style:{

color:"#888",

weight:2,

fillOpacity:0.15

},



onEachFeature:function(feature,layer){


addDropdown(feature);

addHover(feature,layer);


}


}

).addTo(map);



});







function addDropdown(feature){


var name = feature.properties["',
name_variable,
'"];



if(!name) return;



var option=document.createElement("option");


option.value=name;


option.textContent=name;



document

.getElementById("location-select")

.appendChild(option);



}







function addHover(feature,layer){


layer.on({



mouseover:function(e){


e.target.setStyle({

color:"#ff9800",

weight:4,

fillOpacity:0.4

});



layer.bindTooltip(

feature.properties["',
name_variable,
'"],

{

className:"tooltip"

}

).openTooltip();



},




mouseout:function(e){


currentLayer.resetStyle(e.target);


},





click:function(){


document

.getElementById("location-select")

.value =

feature.properties["',
name_variable,
'"];



showSelectedLocation();



}



});



}








function showSelectedLocation(){



var selected =

document

.getElementById("location-select")

.value;





if(currentLayer){


map.removeLayer(currentLayer);


}




var features;




if(selected===""){



features = allData.features;



map.setView([',
map_lat,
',
',
map_lon,
',
',
map_zoom,
']);



}

else{


features = allData.features.filter(f =>


f.properties["',
name_variable,
'"]===selected


);


}






currentLayer = L.geoJSON(


{

type:"FeatureCollection",

features:features


},



{


style:{


color:"#ff6b35",

weight:5,

fillOpacity:0.4


},



onEachFeature:function(feat,layer){



layer.bindPopup(`',

popup_code,

'`);



}



}



).addTo(map);







if(currentLayer.getBounds().isValid()){


map.fitBounds(

currentLayer.getBounds().pad(0.1)

);


}



}




</script>



</body>


</html>


')



# ----------------------------
# EXPORT HTML FILE
# ----------------------------

writeLines(index_simple, "index.html")
