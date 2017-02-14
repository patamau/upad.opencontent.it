<hr/>

{def $page_limit = 50
$subscriptions = fetch( 'content', 'tree', hash( parent_node_id, 1,
class_filter_type, 'include',
class_filter_array, array( 'pre_subscription' ),
limit, $page_limit,
offset, $view_parameters.offset,
attribute_filter, array( array( 'pre_subscription/course', '=', $course.id ) ),
sort_by, array( 'name', true() ) ) )

$subscriptions_count = fetch( 'content', 'tree_count', hash( parent_node_id, 1,
attribute_filter, array( array( 'pre_subscription/course', '=', $course.id ) ),
class_filter_type, 'include',
class_filter_array, array( 'pre_subscription' ) ) )

$count = sum($view_parameters.offset, 1)
}


<form action={concat('courses/list/', $course.id)|ezurl()} method="post">
    <input class="btn btn-primary pull-right" type="submit" name="Presubscribe" value="Preiscrivi utente"/>
</form>


<h2>Lista preiscrizioni</h2>

{if $subscriptions_count|gt(0)}
    <table class="table table-striped m_top_20">
        <tr>
            <th><strong>#</strong></th>
            <th><strong>Data creazione</strong></th>
            <th><strong>Nominativo</strong></th>
            <th><strong>Data conferma</strong></th>
            <th></th>
        </tr>
        {foreach $subscriptions as $subscription}
            <tr{if eq($subscription.data_map.confirmed.content, 1)} class="success"{/if}>
                <td>{$count}</td>
                <td>{$subscription.object.published|l10n(shortdate)}</td>
                <td>{$subscription.data_map.user.content.name|wash()}</td>
                <td>{if eq($subscription.data_map.confirmed.content, 1)}{$subscription.data_map.confirmed_date.content.timestamp|l10n( 'shortdate' )}{/if}</td>
                <td class="text-right">
                    {if eq($subscription.data_map.confirmed.content, 0)}
                        <form action={concat('courses/list/', $course.id)|ezurl()} method="post" class="d_inline_b">
                            <input type="hidden" name="PreSubscriptionID" value="{$subscription.object.id}">
                            <input class="btn btn-xs btn-success" type="submit" name="ConfirmPreSubscription" value="Conferma iscrizione"/>
                        </form>
                        <form method="post" action={"content/action"|ezurl} class="d_inline_b">
                            <input type="hidden" name="RedirectURIAfterRemove"
                                   value="{concat('courses/list/', $course.id)|ezurl(no)}"/>
                            <input type="hidden" name="RedirectIfCancel"
                                   value="{concat('courses/list/', $course.id)|ezurl(no)}"/>
                            <input type="hidden" name="HideRemoveConfirmation" value="0"/>
                            <input type="hidden" name="ContentNodeID"
                                   value="{$subscription.object.main_node_id}"/>
                            <input type="hidden" name="ContentObjectID" value="{$subscription.object.id}"/>
                            <input type="submit" class="btn btn-xs btn-danger" name="ActionRemove"
                                   value="Elimina"/>
                        </form>
                    {else}
                        <p class="text-success">Preiscrizione confermata</p>
                    {/if}
                </td>
            </tr>
            {set $count = $count|sum(1)}
        {/foreach}
    </table>
    {include name=navigator
    uri='design:navigator/google.tpl'
    page_uri=concat('courses/list/', $course.id)
    item_count=$subscriptions_count
    view_parameters=$view_parameters
    item_limit=$page_limit}
{else}
    <div class="alert alert-info m_top_20">
        Non sono presenti preiscrizioni
    </div>
{/if}

{undef $subscriptions $subscriptions_count $count}