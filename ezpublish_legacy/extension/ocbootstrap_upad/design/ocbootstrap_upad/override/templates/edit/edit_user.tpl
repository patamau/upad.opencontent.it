<div class="container">
{def $_redirect = false()}
{if ezhttp_hasvariable( 'LastAccessesURI', 'session' )}
    {set $_redirect = ezhttp( 'LastAccessesURI', 'session' )}
{elseif $object.main_node_id}
    {set $_redirect = concat( 'content/view/full/', $object.main_node_id )}
{elseif ezhttp( 'url', 'get', true() )}
    {set $_redirect = ezhttp( 'url', 'get' )}
{/if}

{def $tab = ''}
{if and( ezhttp_hasvariable( 'tab', 'get' ), is_set( $view_parameters.tab )|not() )}    
    {set $_redirect = concat( $_redirect, '/(tab)/', ezhttp( 'tab', 'get' ) )}
{/if}

<form class="edit" enctype="multipart/form-data" method="post" action={concat("/content/edit/",$object.id,"/",$edit_version,"/",$edit_language|not|choose(concat($edit_language,"/"),''))|ezurl}>
    
	{include uri='design:parts/website_toolbar_edit.tpl'}

  {include uri="design:content/edit_validation.tpl"}
    
  <div class='page-header page-header-with-buttons'>
    <span class="btn btn-sm btn-link pull-right">
        {def $language_index = 0
             $from_language_index = 0
             $translation_list = $content_version.translation_list}
    
        {foreach $translation_list as $index => $translation}
           {if eq( $edit_language, $translation.language_code )}
              {set $language_index = $index}
           {/if}
        {/foreach}
    
        {if $is_translating_content}
    
            {def $from_language_object = $object.languages[$from_language]}
    
            {'Translating content from %from_lang to %to_lang'|i18n( 'design/ezwebin/content/edit',, hash(
                '%from_lang', concat( $from_language_object.name, '&nbsp;<img src="', $from_language_object.locale|flag_icon, '" style="vertical-align: middle;" alt="', $from_language_object.locale, '" />' ),
                '%to_lang', concat( $translation_list[$language_index].locale.intl_language_name, '&nbsp;<img src="', $translation_list[$language_index].language_code|flag_icon, '" style="vertical-align: middle;" alt="', $translation_list[$language_index].language_code, '" />' ) ) )}
        {else}
            {'Content in %language'|i18n( 'design/ezwebin/content/edit',, hash( '%language', $translation_list[$language_index].locale.intl_language_name ))}&nbsp;<img src="{$translation_list[$language_index].language_code|flag_icon}" style="vertical-align: middle;" alt="{$translation_list[$language_index].language_code}" />
        {/if}
    </span>

      <h1>
        <i class='icon-edit'></i>
        <span>Modifica {$object.name|wash}</span>
        <small>{$class.name|wash}</small>
    </h1>
  </div>
    
  <div class="row">
    <div class="col-md-12">
      {if ezini_hasvariable( 'EditSettings', 'AdditionalTemplates', 'content.ini' )}
        {foreach ezini( 'EditSettings', 'AdditionalTemplates', 'content.ini' ) as $additional_tpl}
          {include uri=concat( 'design:', $additional_tpl )}
        {/foreach}
      {/if}
            
      {include uri="design:content/edit_attribute.tpl"}
      
      <!-- inizio sezione gestione ricevute per il tesseramento -->
      {def $user = $object}

    {def $page_limit = 50
	    $subscriptions = fetch(
		    'content', 'tree', hash(
				    parent_node_id, 1,
				    class_filter_type, 'include',
				    class_filter_array, array( 'subscription' ),
				    limit, $page_limit,
				    offset, $view_parameters.offset,
				    attribute_filter, array(
					    array( 'subscription/user', '=', $user.id )
				    ),
				    sort_by, array(
					    array( 'published', true() )
				    )
			    )
		    )
	
	    $subscriptions_count = fetch(
		    'content', 'tree_count', hash(
			    parent_node_id, 1,
			    attribute_filter, array(
				    array( 'subscription/user', '=', $user.id )
			    ),
			    class_filter_type, 'include',
			    class_filter_array, array( 'subscription' )
		    )
	    )
	    $count = sum($view_parameters.offset, 1)
    }

	{include uri="design:parts/card_verify.tpl" subscriptions=$subscriptions}

    <h2>Lista ricevute tesseramenti</h2>

    {if $subscriptions_count|gt(0)}
        <table class="table table-striped m_top_20">
            <tr>
                <th><strong>#</strong></th>
                <th><strong>Data</strong></th>
                <th><strong>Corso</strong></th>
                <th><strong>Ricevute</strong></th>
            </tr>
            {foreach $subscriptions as $subscription}
            	{def $cname = $subscription.data_map.course.content.name|wash()|downcase()}
            	{if $cname|contains('tessera')}
                <tr{if eq($subscription.data_map.annullata.content, 1)} class="danger"{/if}>
                    <td>{$count}</td>
                    <td>{$subscription.object.published|l10n(shortdate)}</td>
                    <td>
                        {$subscription.data_map.course.content.name|wash()}
                    </td>
                    <td>
                        {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
                            {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
                            <ul class="list-inline">
                                <li><a class="btn btn-xs btn-danger" href={concat("layout/set/pdf/invoice/view/",$invoice.id)|ezurl()}>Stampa</a></li>
                                <li><strong>Nr:</strong> {$invoice.invoice_id}</li>
                                <li><strong>Data:</strong> {$invoice.date|l10n(shortdate)}</li>
                                <li><strong>Importo:</strong> {$invoice.total|l10n( 'currency' )}</li>
                            </ul>
                            {undef $invoice}
                        {/foreach}
                    </td>
                </tr>
                {/if}
                {undef $cname}
                {set $count = $count|sum(1)}
            {/foreach}
        </table>
        {include name=navigator
        uri='design:navigator/google.tpl'
        page_uri= concat('courses/list/', $user.id)
        item_count=$subscriptions_count
        view_parameters=$view_parameters
        item_limit=$page_limit}
    {else}
        <div class="alert alert-info m_top_20">
            Non sono presenti tesseramenti
        </div>
    {/if}

    {undef $subscriptions $subscriptions_count $count}
      
      <!-- fine gestione ricevute per il tesseramento -->
    
      <div class="buttonblock">
          <input class="btn btn-lg btn-success pull-right" type="submit" name="PublishButton" value="Salva" />
          <input class="btn btn-lg btn-warning pull-right" type="submit" name="StoreButton" value="Salva bozza" />
          <input class="btn btn-lg btn-danger" type="submit" name="DiscardButton" value="{'Discard'|i18n('design/standard/content/edit')}" />
          <input type="hidden" name="DiscardConfirm" value="0" />
          <input type="hidden" name="RedirectIfDiscarded" value="{$_redirect}" />
          <input type="hidden" name="RedirectURIAfterPublish" value="{$_redirect}" />
      </div>
    </div>        
  </div>   
</form>

{undef $_redirect}
</div>