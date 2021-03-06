{run-once}

{def $domain=ezsys( 'hostname' )|explode('.')|implode('_')}

<script src="http://maps.google.com/maps?file=api&amp;v=2&amp;key=" type="text/javascript"></script>
<script type="text/javascript">

{literal}
/* <![CDATA[ */
function eZGmapLocation_MapView( attributeId, latitude, longitude )
{
    if (GBrowserIsCompatible()) 
    {
        if( latitude && longitude )
            var startPoint = new GLatLng( latitude, longitude ), zoom = 13;
        else
            var startPoint = new GLatLng( 0, 0 ), zoom = 0;

        var map = new GMap2( document.getElementById( 'ezgml-map-' + attributeId ) );
        map.addControl( new GSmallMapControl() );
        map.setCenter( startPoint, zoom );
        map.addOverlay( new GMarker(startPoint) );
    }
}
/* ]]> */
{/literal}

</script>
{/run-once}

{if $attribute.has_content}
<script type="text/javascript">
<!--

if ( window.addEventListener )
    window.addEventListener('load', function(){ldelim} eZGmapLocation_MapView( {$attribute.id}, {first_set( $attribute.content.latitude, '0.0')}, {first_set( $attribute.content.longitude, '0.0')} ) {rdelim}, false);
else if ( window.attachEvent )
    window.attachEvent('onload', function(){ldelim} eZGmapLocation_MapView( {$attribute.id}, {first_set( $attribute.content.latitude, '0.0')}, {first_set( $attribute.content.longitude, '0.0')} ) {rdelim} );

-->
</script>


<div id="ezgml-map-{$attribute.id}" style="width: 100%; height: 280px;"></div>
{/if}
