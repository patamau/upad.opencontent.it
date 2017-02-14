<div class='page-header page-header-with-buttons'>
    <h1 class="pull-left">
        <i class='icon-dashboard'></i>
        <span>{'Dashboard'|i18n( 'design/admin/content/dashboard' )}</span>
    </h1>
</div>

{foreach $blocks as $block}
  
  <div class="dashboard-item">
    {if $block.template}
        {include uri=concat( 'design:', $block.template )}
    {else}
        {include uri=concat( 'design:dashboard/', $block.identifier, '.tpl' )}
    {/if}
  </div>
{/foreach}