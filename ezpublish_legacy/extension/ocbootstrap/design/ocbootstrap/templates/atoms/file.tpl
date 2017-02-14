{set_defaults( hash(  
  'view', 'download_button',
  'size', 'btn-lg'
))}

{if and( $view|eq( 'flip' ), flip_exists( $file.contentobject_id )|not() )}
  {set $view = 'download_button'}
{/if}

{if is_set( $file.contentclassattribute_id )}

  {if or( $view|eq( 'download_button' ), flip_exists( $file.contentobject_id )|not() )}
    <div class="download-file">
        <p>
          <a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="btn btn-primary {$size}">
            <span class="glyphicon glyphicon-download-alt"></span>
            {$file.content.original_filename|wash( xhtml )} {$file.content.filesize|si( byte )}
          </a>
        </p>
    </div>
  {elseif and( $view|eq( 'flip' ), flip_exists( $file.contentobject_id ) )}

	  {def $pageDim = get_page_dimensions( $file.contentobject_id, 'large' )
		   $heigth = $pageDim[1]}
	
	  {ezscript_require( array( 'megazine.js', 'swfaddress.js', 'swfobject.js' ) )}
	  {ezcss_require( array('flip.css') )}
	
	  <script type="text/javascript">
	  {literal}
	  swfobject.embedSWF(
		  {/literal}{concat( 'flash/megazine/megazine.swf')|ezdesign}{literal},
		  "megazine",
		  "100%",
		  "{/literal}{$heigth}{literal}",
		  "9.0.115",
		  {/literal}{concat( 'flash/swfobject/expressInstall.swf')|ezdesign}{literal},
		  {
			  {/literal}xmlFile : 'application_flip/{$file.object.id}/magazine_large.xml'{literal},
			  minScale : 1.0,
			  maxScale : 1.0,
			  top: "20"
		  },
		  {
		  bgcolor : "#fff",
		  wmode : "transparent",
		  allowFullscreen : "true"
		  },
		  {id : "megazine"}
	  );
	  {/literal}
	  </script>
	  <div id="megazine"></div>
    
    <div class="download-file">
        <p class="text-center">
          <a href="{concat( 'content/download/', $file.contentobject_id, '/', $file.id,'/version/', $file.version , '/file/', $file.content.original_filename|urlencode )|ezurl( 'no' )}" class="btn btn-primary btn-sm">
            <span class="glyphicon glyphicon-download-alt"></span>
            {$file.content.original_filename|wash( xhtml )} {$file.content.filesize|si( byte )}
          </a>
        </p>
    </div>
		
  {/if}
{/if}