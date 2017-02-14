{* Attensione $geo_items è un array di array( id => 123, lat => 123, lng => 123, info => "<h5>Info</h5>..." ), array( ... ), ... *}
{set_defaults( hash(  
  'id', 'map_canvas',
  'width', '100%',
  'height', '400px'
))}

{run-once}
<script src="https://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"></script>
{run-once}

<script type="text/javascript">
var map;
var infowindow;
var markers = [];
var next=0;
var pinShadow = new google.maps.MarkerImage("http://chart.apis.google.com/chart?chst=d_map_pin_shadow",
  new google.maps.Size(40, 37),
  new google.maps.Point(0, 0),
  new google.maps.Point(12, 35)
);

{foreach $geo_items as $geo_item}		
  markers[{$geo_item.id}] = {ldelim}center : new google.maps.LatLng( {$geo_item.lat},{$geo_item.lng} ),info: "{$geo_item.info|wash(javascript)}"{rdelim};		
{/foreach}	

function initialize() {ldelim}
  var mapOptions = {ldelim}
    zoom: 2,
    center: new google.maps.LatLng(46.0696924, 11.1210886),
    mapTypeId: google.maps.MapTypeId.TERRAIN
  {rdelim};  
  map = new google.maps.Map(document.getElementById('{$id}'), mapOptions);

  for (var i in markers) {ldelim}
    createMarkerAndInfoWindow( i );
  {rdelim}
{rdelim}

function createMarkerAndInfoWindow( i ) {ldelim}
  var marker = new google.maps.Marker({ldelim}
    map: map,
    position: markers[i].center,
    shadow: pinShadow,
    content: markers[i].info
  {rdelim});
  infowindow = new google.maps.InfoWindow({ldelim}
    content: markers[i].info,
    position: markers[i].center,
    maxWidth: 450
  {rdelim});
  google.maps.event.addListener( marker, 'click', function(){ldelim}
    map.setCenter( marker.getPosition() );
    map.setZoom( 3 );
    infowindow.setContent( marker.content );
    infowindow.open( map, marker );
  {rdelim});
{rdelim}
google.maps.event.addDomListener(window, 'load', initialize);
</script>

<div id="{$id}" style="height: {$height}; width: {$width};"></div>