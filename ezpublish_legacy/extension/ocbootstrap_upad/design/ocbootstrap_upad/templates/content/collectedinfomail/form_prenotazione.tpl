{def $recipient = $object.data_map.recipient.content}

{def $idCorso = false()}
{foreach $collection.attributes as $attribute}
  {if $attribute.contentclass_attribute.identifier|eq('id_corso')}
    {set $idCorso = $attribute.data_int}
  {/if}
{/foreach}

{def $corso = fetch( content, node, hash( node_id, $idCorso ) )}
{if $corso}
  {foreach $corso.data_map.ente.content.relation_list as $ente}
    {def $ente = fetch( content, object, hash( object_id, $ente.contentobject_id ) )}
    {if $ente}
      {set $recipient = $ente.data_map.email_prenotazione.content}
      {break}
    {/if}
  {/foreach}
{/if}

{set-block scope=root variable=subject}Prenotazione corso {$corso.name|wash()}{/set-block}
{set-block scope=root variable=email_receiver}{$recipient}{/set-block}
{set-block scope=root variable=content_type}text/html{/set-block}

{* Set this to redirect to another node
{set-block scope=root variable=redirect_to_node_id}2{/set-block}
*}

<h3>Prenotazione corso <a href={$corso.url_alias|ezurl()}>{$corso.name|wash()}</a></h3>
<table cellspacing="0" cellpadding="0" border="0"  style="width:100%">
{foreach $collection.attributes as $attribute}
<tr>
  <th><strong>{$attribute.contentclass_attribute_name|wash}</strong></th>
  <td>{attribute_result_gui view=info attribute=$attribute}</td>
</tr>
{/foreach}
</table>

{*{$ente.data_map.email_prenotazione.content}*}