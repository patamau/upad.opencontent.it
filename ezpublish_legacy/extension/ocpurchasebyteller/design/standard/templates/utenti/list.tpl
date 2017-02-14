<div class="container">
    <div class="col-md-12 m_bottom_20">
        <ul class="nav nav-tabs">
            <li role="presentation" class="active"><a href="{'utenti/list'|ezurl(no)}"><i class="fa fa-users"></i> Utenti</a></li>
            <li role="presentation"><a href="{'courses/list'|ezurl(no)}"><i class="fa fa-book"></i> Corsi</a></li>
            <li role="presentation"><a href="{'courses/archive'|ezurl(no)}"><i class="fa fa-archive"></i> Archivio</a></li>
        </ul>
    </div>
<div class="col-md-12 m_bottom_20">
    <a class="btn pull-right btn-primary" href="{'utenti/export'|ezurl(no)}"><i class="fa fa-download" aria-hidden="true"></i> Esporta utenti iscritti</a>
    <a class="btn pull-right btn-danger" href="{concat( 'add/new/user/?parent=', ezini("UserSettings", "DefaultUserPlacement") )|ezurl(no)}"><i class="fa fa-user" aria-hidden="true"></i> Aggiungi utente</a>
    <h1>Sezione per gestire gli utenti</h1>
</div>

<section class="col-lg-9 col-md-9 col-sm-8 m_xs_bottom_30">

{def $page_url = '/utenti/list'
     $page_limit = 30
     $data = class_search_result(  hash( 'sort_by', hash( 'score', 'desc' ), 'limit', $page_limit ), $view_parameters )
     $children = array()
     $count = 0}

  {if and( $data.is_search_request, is_set($view_parameters.class_id) )}
      {set $children = $data.contents
           $count = $data.count}
  {else}
    {set $children = fetch( 'content', 'tree', hash( parent_node_id, 12, main_node_only, true(), class_filter_type, 'include', 'class_filter_array', array( 'user' ), 'limit', $page_limit, 'offset', $view_parameters.offset, sort_by, array( 'name', true() ) ))
         $count = fetch( 'content', 'tree_count', hash( parent_node_id, 12, main_node_only, true(), class_filter_type, 'include', 'class_filter_array', array( 'user' ) ))}
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
    <tr>
      <td>
          <a href="{concat( $page_url, '/', $node.object.id)|ezurl(no)}"><strong>{$node.name}</strong></a>
      </td>
      <td>
        <ul class="list-inline">
            <li>
                <a href="{concat( $page_url, '/', $node.object.id)|ezurl(no)}" class="has_tooltip" data-toggle="tooltip" data-placement="top" title="Visualizza">
                    <span class="fa-stack"><i class="fa fa-circle fa-stack-2x"></i><i class="fa fa-eye fa-stack-1x fa-inverse"></i></span>
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
      <figure class="widget shadow r_corners wrapper m_bottom_30">
        <figcaption>
            <h3 class="color_light">Cerca per nome</h3>
        </figcaption>
        <div class="widget_content">
          <form action={$page_url|ezurl} method="GET">
            <input type="text" class="form-control m_bottom_20" name="Search" placeholder="Cerca per nome" value="{$view_parameters.query|wash()}"/>
            <p class="t_align_c"><button class="button_type_4 r_corners bg_scheme_color color_light tr_all_hover" type="submit">Cerca utente</button></p>
          </form>
        </div>
      </figure>
    </aside>
</div>
