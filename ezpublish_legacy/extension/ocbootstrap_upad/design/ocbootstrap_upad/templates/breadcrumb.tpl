<section class="breadcrumbs">
    <div class="container">
        <ul class="horizontal_list clearfix bc_list f_size_medium">
            {foreach $pagedata.path_array as $path}
                {if $path.url}
                    <li class="m_right_10 current">
                        <a href="{cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl('no')}" class="default_t_color">{$path.text|wash}<i class="fa fa-angle-right d_inline_middle m_left_10"></i></a>
                    </li>
                {else}
                  <li><span class="scheme_color"><strong>{$path.text|wash}</strong></span></li>
                {/if}
            {/foreach}
        </ul>
    </div>
</section>

{*
<!-- Path content: START -->
<div class="container">
  <ul class="breadcrumb">
    {foreach $pagedata.path_array as $path}
      {if $path.url}
        <li>
          <a href={cond( is_set( $path.url_alias ), $path.url_alias, $path.url )|ezurl}>{$path.text|wash}</a>
        </li>
      {else}
        <li class="active">
          {$path.text|wash}
        </li>
      {/if}
    {/foreach}
  </ul>
</div>
<!-- Path content: END -->
*}
