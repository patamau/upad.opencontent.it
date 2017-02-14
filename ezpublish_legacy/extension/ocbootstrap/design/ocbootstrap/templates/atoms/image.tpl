{set_defaults( hash(  
  'use_html5_tag', false(),  
  'caption', false(),  
  'image_class', 'medium',
  'css_classes', 'image',
  'alignment', false(),
  'link_to_image', false(),
  'href', false(),
  'target', false(),
  'hspace', false(),
  'border_size', 0,
  'border_color', '',
  'border_style', '',
  'margin_size', '',
  'alt_text', '',
  'fluid', true(),
  'title', ''  
))}

{if $node|has_attribute( 'image' )}

  {switch match=$alignment}
    {case match='left'}        
      {set $css_classes = $css_classes|concat( 'pull-left' )}
    {/case}
    {case match='right'}
      {set $css_classes = $css_classes|concat( 'pull-right' )}
    {/case}
    {case/}
  {/switch}
  
  {if $use_html5_tag}
    {def $openFigure = concat( '<figure class="', $css_classes, '">' )
         $closeFigure = '</figure>'
         $openCaption = concat( '<figcaption class="figure ', $css_classes, '">' )
         $closeCaption = '</figcaption>'
    }
  {else}
    {def $openFigure = concat( '<div class="figure ', $css_classes, '">' )
         $closeFigure = '</div>'
         $openCaption = concat( '<div class="figcaption ', $css_classes, '">' )
         $closeCaption = '</div>'
    }
  {/if}
  
  
  {$openFigure}
  
  {attribute_view_gui attribute=$node|attribute( 'image' ) image_class=$image_class link_to_image=$link_to_image href=$href target=$target hspace=$hspace border_size=$border_size border_color=$border_color border_style=$border_style margin_size=$margin_size alt_text=$alt_text fluid=$fluid alignment=cond($alignment|eq('center'),$alignment,false())}
  
  {* caption deve essere un attributo *}
  {if is_set( $caption.contentclassattribute_id )}
    {$openCaption}
      {if $title}
        <h3>
          {if $href}
            <a target="{$target}" href={$href}>{$title}</a>
            {else}
            {$title}
          {/if}
        </h3>
      {/if}    
      {attribute_view_gui attribute=$caption}
    {$closeCaption}
  {/if}
  
  {$closeFigure}

{/if}