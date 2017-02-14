{* Product - Full view *}
<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    {if $node|has_attribute( 'short_description' )}
      <div class="abstract">
        {attribute_view_gui attribute=$node|attribute( 'short_description' )}
      </div>
    {/if}
    
    {include uri='design:atoms/image.tpl' item=$node image_class=appini( 'ContentViewFull', 'DefaultImageClass', 'wide' ) caption=$node|attribute( 'caption' )}
	
    {if $node|has_attribute( 'description' )}
      <div class="description">
        {attribute_view_gui attribute=$node|attribute( 'description' )}
      </div>
    {/if}	  
	
    {if $node|has_attribute( 'tags' )}
      <div class="tags">
        {attribute_view_gui attribute=$node|attribute( 'tags' )}
      </div>
    {/if}
    
    {if $node|has_attribute( 'star_rating' )}
      <div class="rating">
        {attribute_view_gui attribute=$node|attribute( 'star_rating' )}
      </div>
    {/if}
    
    {include uri='design:parts/social_buttons.tpl'}
    
    {if $node|has_attribute( 'comments' )}
      <div class="comments">
        {attribute_view_gui attribute=$node|attribute( 'comments' )}
      </div>
    {/if}

  </div>
  
  {* Per visualizzare l'extrainfo: aggiungi la classe "full-stack" al primo div e scommenta la seguenta inclusione *}
  {*include uri='design:parts/content-related.tpl'*}

</div>
{*
<section class="content-view-full">
    <article class="class-product row">
        <div class="span8">
            {if $node.data_map.image.has_content}
                <div class="attribute-image full-head">
                    {attribute_view_gui attribute=$node.data_map.image image_class=productimage}

                    {if $node.data_map.caption.has_content}
                        <div class="attribute-caption">
                            {attribute_view_gui attribute=$node.data_map.caption}
                        </div>
                    {/if}
                </div>
            {/if}

            <div class="attribute-short">
               {attribute_view_gui attribute=$node.data_map.short_description}
            </div>

            <div class="attribute-long">
               {attribute_view_gui attribute=$node.data_map.description}
            </div>

            {def $product_category_attribute=ezini( 'VATSettings', 'ProductCategoryAttribute', 'shop.ini' )}
            {if and( $product_category_attribute, is_set( $node.data_map.$product_category_attribute ) )}
            <div class="attribute-long">
              <p>Category:&nbsp;{attribute_view_gui attribute=$node.data_map.$product_category_attribute}</p>
            </div>
            {/if}
            {undef $product_category_attribute}

           {def $related_purchase=fetch( 'shop', 'related_purchase', hash( 'contentobject_id', $node.object.id, 'limit', 10 ) )}
           {if $related_purchase}
            <div class="relatedorders">
                <h2>{'People who bought this also bought'|i18n( 'design/ocbootstrap/full/product' )}</h2>

                <ul>
                {foreach $related_purchase as $product}
                    <li>{content_view_gui view=text_linked content_object=$product}</li>
                {/foreach}
                </ul>
            </div>
           {/if}
           {undef $related_purchase}
        </div>
        <div class="span4">
            <aside>
                <section class="content-view-aside">
                    <div class="product-main">
                        <div class="attribute-header">
                            <h2>{$node.name|wash()}</h2>
                            <span class="subheadline">{attribute_view_gui attribute=$node.data_map.product_number}</span>
                        </div>
                        <article>
                            <form method="post" action={"content/action"|ezurl}>
                                <fieldset class="row">
                                    <div class="item-price span4">
                                    {if $node.data_map.price.has_discount}
                                        {$node.data_map.price.content.discount_price_inc_vat|l10n( 'currency' )} <span class="old-price">{$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}</span>
                                    {else}
                                        {$node.data_map.price.content.inc_vat_price|l10n( 'currency' )}
                                    {/if}
                                    </div>
                                    <div class="span4">
                                        {attribute_view_gui attribute=$node.data_map.additional_options}
                                    </div>
                                    <div class="item-buying-action form-inline span4">
                                        <label>
                                            <span class="hidden">{'Amount'|i18n("design/ocbootstrap/full/product")}</span>
                                            <input type="text" name="Quantity" />
                                        </label>
                                        <button class="btn btn-warning" type="submit" name="ActionAddToBasket">
                                        {'Add to basket'|i18n("design/ocbootstrap/full/product")}
                                        </button>
                                    </div>
                                </fieldset>
                                <input type="hidden" name="ContentNodeID" value="{$node.node_id}" />
                                <input type="hidden" name="ContentObjectID" value="{$node.object.id}" />
                                <input type="hidden" name="ViewMode" value="full" />
                            </form>
                        </article>
                        <div class="attribute-socialize">
                            {include uri='design:parts/social_buttons.tpl'}
                        </div>
                    </div>
                </section>
            </aside>
        </div>
   </article>
</section>
*}