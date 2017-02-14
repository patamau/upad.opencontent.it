{*
  items - required - objects to show in the carousel
  title - the title of the block
  root_node - required to give a unique id to the carousel - the node to point with the link from the title
  autoplay - sets if the carousel should automatically cycle
  interval - the transition time for the carousel
  controls - whether to show navigation controls or not (arrow left/right) - default is true
  indicators - whether to show navigation indicators or not (small dots) - default is false

*}

{def $time_limit = 0
     $nav_controls = true()
     $nav_indicators = false()
     $c_size = 8
     $i_view = 'carousel_item'
}

{if eq($autoplay,1)}
  {set $time_limit = 4000}
  {if is_set($interval)}
    {set $time_limit = $interval}
  {/if}
{/if}

{if is_set($content_size)}
  {set $c_size = $content_size}

{/if}

{if is_set($controls)}
  {set $nav_controls = $controls}
{/if}

{if is_set($indicators)}
  {set $nav_indicators = $indicators}
{/if}

{if is_set($view)}
  {set $i_view = $view}
{/if}

{if $items}
  {if $root_node}
    {ezscript_require( array( 'ezjsc::jquery', 'bootstrap-transition.js' , 'bootstrap-carousel.js' ) )}

      {if $title}
        <h2><a href={$root_node.url_alias|ezurl()}>{$title}</a></h2>
      {/if}

      <div id="carousel_{$root_node.node_id}" class="carousel slide" data-ride="carousel">

        {*
         only show nav indicators if
         - nav_indicators is set to true
         - there's more than one item to show
       *}
        {if and($nav_indicators, $items|count()|gt(1))}
        <!-- Carousel nav indicators -->
          <ol class="carousel-indicators">
            {foreach $items as $k => $item}
            <li data-target="carousel_{$root_node.node_id}" data-slide-to="{$k}"></li>
            {/foreach}
          </ol>
        {/if}

        <!-- Carousel items -->
        <div class="carousel-inner">
        {foreach $items as $i => $item}
          <div class="item{if eq($i,0)} active{/if}">
            {node_view_gui content_node=$item view=$i_view content_size=$c_size image_class=carousel_tall}
          </div>
        {/foreach}
        </div>

        {*
          only show nav controls if
          - nav_controls is set to true
          - there's more than one item to show
        *}
        {if and($nav_controls, $items|count()|gt(1))}
          <!-- Carousel nav controls -->
          <a class="carousel-control left" href="#carousel_{$root_node.node_id}" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
          <a class="carousel-control right" href="#carousel_{$root_node.node_id}" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
        {/if}
      </div>

    <script>
      var time_limit = {$time_limit}
      {literal}
      $('.carousel').carousel({interval: time_limit})
      {/literal}
    </script>

  {/if}
{/if}

{undef}