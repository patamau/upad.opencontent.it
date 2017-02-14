<!-- Footer area: START -->
{def $footer_node = fetch( 'content', 'node', hash( 'node_id', ezini( 'FooterSettings', 'NodeID', 'content.ini' ) ) )}
<footer>    
    {if $footer_node}
    <div class="container">
        <div class="row">
            <div class="span4">
                {include uri='design:footer/address.tpl' node=$footer_node}
            </div>
            <div class="span4 nav-collapse">
                {include uri='design:footer/latest_news.tpl'}
            </div>
            <div class="span4 nav-collapse">
                {include uri='design:footer/links.tpl' node=$footer_node}
            </div>
        </div>
    </div>
    {/if}
</footer>
<!-- Footer area: END -->
{undef $footer_node}
