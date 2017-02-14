{* https://github.com/blueimp/Gallery vedi anche page_extra.tpl *}
{ezscript_require( array( "ezjsc::jquery", "plugins/blueimp/jquery.blueimp-gallery.min.js" ) )}
{ezcss_require( array( "plugins/blueimp/blueimp-gallery.css" ) )}

{set_defaults( hash(  
  'thumbnail_class', 'squarethumb',
  'wide_class', 'imagefullwide',
  'items', array()
))}

<div class="gallery row">    
    {foreach $items as $item}
	<div class="col-xs-6 col-md-2">
      <a class="thumbnail" href={$item|attribute('image').content[$wide_class].url|ezroot} title="{$item.name}" data-gallery>
        {attribute_view_gui attribute=$item|attribute('image') image_class=$thumbnail_class fluid=false()}
      </a>
	</div>
	{/foreach}    
</div>