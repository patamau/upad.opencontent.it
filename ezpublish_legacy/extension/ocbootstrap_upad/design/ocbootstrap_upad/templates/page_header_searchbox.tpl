{*
<form class="relative type_2 m_top_5" role="search">
    <input type="text" placeholder="Search" name="search" class="r_corners f_size_medium full_width">
    <button class="f_right search_button tr_all_hover f_xs_none">
        <i class="fa fa-search"></i>
    </button>
</form>
*}

<form role="search" class="relative type_2 m_top_5" method="get" action="{'/content/search'|ezurl( 'no' )}" id="site-wide-search">
    {if $pagedata.is_edit}
        <input class="r_corners f_size_medium full_width" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" disabled="disabled" />
    {else}
          <input class="r_corners f_size_medium full_width" type="search" name="SearchText" id="site-wide-search-field" placeholder="{'Search'|i18n('design/ocbootstrap/pagelayout')}" />
          <button type="submit" class="f_right search_button tr_all_hover f_xs_none"><i class="fa fa-search"></i></button>
      {if eq( $ui_context, 'browse' )}
          <input name="Mode" type="hidden" value="browse" />
      {/if}
    {/if}
</form>
