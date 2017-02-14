{set_defaults( hash(  
  'image_class', 'squaremedium',  
  'items', array(),
  'wide_class', 'original',
  'show_number', 3,
  'show_gallery', true()
))}

{if count($items)|gt(0)}

{ezscript_require( array( 'ezjsc::jquery', 'plugins/owl-carousel/owl.carousel.min.js', "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
{ezcss_require( array( 'plugins/owl-carousel/owl.carousel.css', 'plugins/owl-carousel/owl.theme.css', "plugins/blueimp/blueimp-gallery.css" ) )}

<div id="{$items[0].name|slugize()}" class="owl-carousel">
  {foreach $items as $item}
	<div class="item text-center">
	  
	  <a href={if $show_gallery}{$item|attribute('image').content[$wide_class].url|ezroot}{else}{$item.url_alias|ezurl()}{/if} title="{$item.name}" {if $show_gallery}data-gallery{/if}>
		{attribute_view_gui attribute=$item|attribute( 'image' ) image_class=$image_class alignment=center}
	  </a>
			  
	</div>
  {/foreach}  
</div>

<script>
$(document).ready(function() {ldelim}
  $("#{$items[0].name|slugize()}").owlCarousel({ldelim}
	items : {$show_number},
	itemsDesktop : [1000,{$show_number}], // items between 1000px and 901px
  itemsDesktopSmall : [900,2], // betweem 900px and 601px
  itemsTablet: [600,2], // items between 600 and 0
	itemsMobile : [400,1]
  {rdelim});
{rdelim});
</script>

{/if}