{def $ente = false()
     $codice_area = false() }
<div class="container">
    <div class="col-md-12 m_bottom_20">
        <ul class="nav nav-tabs">
            <li role="presentation"><a href="{'utenti/list'|ezurl(no)}"><i class="fa fa-users"></i> Utenti</a></li>
            <li role="presentation"><a href="{'courses/list'|ezurl(no)}"><i class="fa fa-book"></i> Corsi</a></li>
            <li role="presentation" class="active"><a href="{'courses/archive'|ezurl(no)}"><i class="fa fa-archive"></i> Archivio</a></li>
        </ul>
    </div>
<div class="col-md-12 m_bottom_20">
<h1>Sezione per gestire i corsi archiviati</h1>
</div>

<section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">

{def $page_url = '/courses/archive'
     $page_limit = 30
     $data = class_search_result(  hash( 'sort_by', hash( 'name', 'asc' ), 'limit', $page_limit, 'ignore_visibility', true(), subtree_array, array( 138, 506, 507, 508, 14383 ) ), $view_parameters )
     $children = array()
     $count = 0}

  {if and( $data.is_search_request, is_set($view_parameters.class_id) )}
      {set $children = $data.contents
           $count = $data.count}
  {else}
    {set $children = fetch( 'content', 'tree', hash( parent_node_id, array(138, 506, 507, 508, 14383), main_node_only, true(), ignore_visibility, true(), class_filter_type, 'include', 'class_filter_array', array( 'corso' ), 'limit', $page_limit, 'offset', $view_parameters.offset, sort_by, array( 'name', true() ) ))
         $count = fetch( 'content', 'tree_count', hash( parent_node_id, array(138, 506, 507, 508, 14383), main_node_only, true(), ignore_visibility, true(), class_filter_type, 'include', 'class_filter_array', array( 'corso' ) ))}
  {/if}

  {if and( $data.is_search_request, is_set($view_parameters.class_id) )}
    <div class="navigation clearfix m_bottom_25 m_sm_bottom_20">
      {foreach $data.fields as $field}
          <a class="tr_delay_hover r_corners button_type_16 f_size_medium bg_dark_color bg_cs_hover color_light m_xs_bottom_5" href={concat( $page_url, $field.remove_view_parameters )|ezurl()}>
              <i class="fa fa-times m_right_5"></i> <strong>{$field.name}:</strong> {if is_array($field.value)}{foreach $field.value as $value}{$value}{delimiter}, {/delimiter}{/foreach}{else}{$field.value}{/if}
          </a>
          {delimiter}&nbsp;{/delimiter}
      {/foreach}
      &nbsp;<a class="tr_delay_hover r_corners button_type_16 f_size_medium bg_scheme_color color_light m_xs_bottom_5" href={$page_url|ezurl()}>Annulla ricerca</a>
    </div>
    {if $data.count|eq(0)}
      <p>Nessun risultato</p>
    {/if}
  {/if}

  <table class="table">
  {foreach $children as $node}
      {set $ente = fetch( content, object, hash( object_id, $node.data_map.ente.content.relation_list[0].contentobject_id ) )
           $codice_area = fetch( content, object, hash( object_id, $node.data_map.codice_area.content.relation_list[0].contentobject_id ) ) }
    <tr>
      <td>
        <a href="{concat( $page_url, '/', $node.contentobject_id)|ezurl(no)}"><strong>{$node.name}</strong></a>
      </td>
        <td>{$codice_area.data_map.codice.content}-{$ente.data_map.codice.content}-{$node.data_map.anno.content}-{$node.data_map.codice.content}-{$node.data_map.edizione.content}</td>
      <td><strong class="color_dark">{$node.data_map.edizione.content}</strong></td>
      <td>
        <ul class="list-inline">
            <li>
              <a href="{$node.url_alias|ezurl(no)}" class="has_tooltip" data-toggle="tooltip" data-placement="top" title="Visualizza">
                <span class="fa-stack">
                  <i class="fa fa-circle fa-stack-2x"></i>
                  <i class="fa fa-eye fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
            {if $node.object.can_edit}
            <li>
              <a href="{concat( 'content/edit/', $node.object.id, '/f/', $node.object.default_language )|ezurl('no')}" class="has_tooltip" data-toggle="tooltip" data-placement="top" title="Modifica">
                <span class="fa-stack">
                  <i class="fa fa-circle fa-stack-2x"></i>
                  <i class="fa fa-pencil fa-stack-1x fa-inverse"></i>
                </span>
              </a>
            </li>
            {/if}
            {if $node.object.can_edit}
                <li>
                    <a href="{concat( 'courses/archive/', $node.object.id, '?Restore=true' )|ezurl('no')}" class="has_tooltip" data-toggle="tooltip" data-placement="top" title="Ripristina">
                        <span class="fa-stack"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-level-up fa-stack-1x fa-inverse" aria-hidden="true"></i>
                        </span>
                    </a>
                </li>
            {/if}
        </ul>
      </td>
    </tr>
  {/foreach}
  </table>

    {include name=navigator
            uri='design:navigator/google.tpl'
            page_uri=$page_url
            item_count=$count
            view_parameters=$view_parameters
            item_limit=$page_limit}




</section>

<aside class="col-lg-3 col-md-3 col-sm-4 m_xs_bottom_30">

  {*<figure class="widget shadow r_corners wrapper m_bottom_30">
    <figcaption>
        <h3 class="color_light">Cerca per nome</h3>
    </figcaption>
    <div class="widget_content">
      <form action={$page_url|ezurl} method="GET">
        <input type="text" class="form-control m_bottom_20" name="Search" placeholder="Cerca per nome" value="{$view_parameters.query|wash()}"/>
        <p class="t_align_c"><button class="button_type_4 r_corners bg_scheme_color color_light tr_all_hover" type="submit">Cerca attività</button></p>
      </form>
    </div>
  </figure>*}

  {class_search_form( 'corso', hash( 'RedirectUrlAlias', $page_url ) )}
</aside>
</div>

{undef $ente $codice_area}