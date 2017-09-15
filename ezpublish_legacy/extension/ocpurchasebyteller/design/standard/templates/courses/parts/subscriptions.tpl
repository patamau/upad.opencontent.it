<hr/>
{if is_set( $view_parameters.orderby )|not}
	{def $orderby='name' 
		$orderasc=true()
	}
{else}
	{def $orderby=$view_parameters.orderby
		$orderasc=$view_parameters.orderasc
	}
{/if}
{def $page_limit = 50
$subscriptions = fetch(
    'content', 'tree', hash(
        parent_node_id, 1,
        class_filter_type, 'include',
        class_filter_array, array( 'subscription' ),
        limit, $page_limit,
        offset, $view_parameters.offset,
        attribute_filter, array(
            array( 'subscription/course', '=', $course.id )
        ),
        sort_by, array( $orderby, $orderasc )

    )
)

$subscriptions_count = fetch( 'content', 'tree_count', hash( parent_node_id, 1,
attribute_filter, array( array( 'subscription/course', '=', $course.id ) ),
class_filter_type, 'include',
class_filter_array, array( 'subscription' ) ) )

$count = sum($view_parameters.offset, 1)
}

{*
sort_by, array(
            array('attribute', true(), 'subscription/annullata'),
            array( 'published', true() )
        )
*}


<form action={concat('courses/list/', $course.id)|ezurl()} method="post" class="text-right pull-right">
    <input class="btn btn-primary" type="submit" name="Subscribe" value="Iscrivi utente esistente"/>
    <input class="btn btn-danger" type="submit" name="CreateAndSubscribe" value="Crea utente ed iscrivi al corso"/>
</form>
<div class="dropdown pull-right m_right_10">
    <button class="btn btn-default dropdown-toggle" type="button" id="dropdownMenu1" data-toggle="dropdown"
            aria-expanded="true">Documenti<span class="caret"></span></button>
    <ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu1">
        <li role="presentation"><a role="menuitem" tabindex="-1"
                                   href="{concat( 'export/subscriptions/', $course.id )|ezurl(no)}">Lista
                iscritti</a></li>
        <li role="presentation"><a role="menuitem" tabindex="-1"
                                   href="{concat( 'export/subscriptions/', $course.id , '/full' )|ezurl(no)}">Lista
                iscritti completa</a></li>
        <li role="presentation"><a role="menuitem" tabindex="-1"
                                   href="{concat( 'layout/set/a4/export/docs/teachers_lessons/', $course.id )|ezurl(no)}">Lezioni
                docente </a></li>
        <li role="presentation"><a role="menuitem" tabindex="-1"
                                   href="{concat( 'layout/set/a4/export/docs/teachers_attendance/', $course.id )|ezurl(no)}">Presenze
                professori</a></li>
        <li role="presentation"><a role="menuitem" tabindex="-1"
                                   href="{concat( 'layout/set/a4_landscape/export/docs/attendance/', $course.id )|ezurl(no)}">Presenze</a>
        </li>
        <li role="presentation"><a role="menuitem" tabindex="-1"
                                   href="{concat( 'layout/set/a4/export/docs/subscriptions/', $course.id )|ezurl(no)}">Lista
                iscritti/confermati</a></li>
    </ul>
</div>

<h2>Lista iscrizioni</h2>

{if $subscriptions_count|gt(0)}
    <table class="table table-striped m_top_20">
        <tr>
            <th><strong>#</strong></th>
            <th><a href="{concat('/courses/list/',$course.id)|concat('/(orderby)/published/(orderasc)/0')|ezurl('no')}"><i class="fa fa-sort-desc"></i></a> <strong>Data</strong></th>
            <th><a href="{concat('/courses/list/',$course.id)|concat('/(orderby)/name/(oderasc)/1')|ezurl('no')}"><i class="fa fa-sort-desc"></i></a> <strong>Nominativo</strong></th>
            <th><strong>Ricevute</strong></th>
            <th></th>
        </tr>
            {foreach $subscriptions as $subscription}
                <tr{if eq($subscription.data_map.annullata.content, 1)} class="danger"{/if}>
                    <td>{$count}</td>
                    <td>{$subscription.object.published|l10n(shortdate)}</td>
                    <td>
                        {if $subscription.data_map.user.content.can_edit}
                            <a target="{$subscription.data_map.user.content.id}" href="{concat( 'utenti/list/', $subscription.data_map.user.content.id, '/f/', $subscription.data_map.user.content.default_language )|ezurl('no')}" class="has_tooltip" data-toggle="tooltip" data-placement="top" title="Modifica">
                                {$subscription.data_map.user.content.name|wash()}
                            </a>
                        {else}
                            {$subscription.data_map.user.content.name|wash()}
                        {/if}
                    </td>
                    <td>
                        {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
                            {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
                            <ul class="list-inline">
                                <li><strong>Nr:</strong> {$invoice.invoice_id}</li>
                                <li><strong>Data:</strong> {$invoice.date|l10n(shortdate)}</li>
                                <li><strong>Importo:</strong> {$invoice.total|l10n( 'currency' )}</li>
                            </ul>
                            {undef $invoice}
                        {/foreach}
                    </td>
                    <td class="text-right">
                        {if eq($subscription.data_map.annullata.content, 0)}
                            <a class="btn btn-xs btn-warning"
                               href="{concat( 'courses/make_payment/', $course.id, '/', $subscription.data_map.user.content.id )|ezurl(no)}"
                               title="Dettaglio ricevute">Pagamenti e storni</a>
                            {* Rimosso controllo per richiesta trach #12 *}
                            {*if $subscription.data_map.invoices.has_content|not()}
                                <form method="post" action={"content/action"|ezurl} class="d_inline_b">
                                    <input type="hidden" name="RedirectURIAfterRemove"
                                           value="{concat('courses/list/', $course.id)|ezurl(no)}"/>
                                    <input type="hidden" name="RedirectIfCancel"
                                           value="{concat('courses/list/', $course.id)|ezurl(no)}"/>
                                    <input type="hidden" name="HideRemoveConfirmation" value="0"/>
                                    <input type="hidden" name="ContentNodeID"
                                           value="{$subscription.object.main_node_id}"/>
                                    <input type="hidden" name="ContentObjectID" value="{$subscription.object.id}"/>
                                    <input type="submit" class="btn btn-sm btn-danger" name="ActionRemove"
                                           value="Elimina"/>
                                </form>
                            {else}
                                <form action={concat('courses/list/', $course.id)|ezurl()} method="post"
                                      class="d_inline_b">
                                    <input type="hidden" name="SubscriptionID" value="{$subscription.object.id}">
                                    <input class="btn btn-sm btn-primary" type="submit" name="Unsubscribe"
                                           value="Annulla iscrizione"/>
                                </form>
                            {/if*}
                            <form action={concat('courses/list/', $course.id)|ezurl()} method="post"
                                  class="d_inline_b">
                                <input type="hidden" name="SubscriptionID" value="{$subscription.object.id}">
                                <input class="btn btn-xs btn-danger" type="submit" name="Unsubscribe"
                                       value="Annulla iscrizione"/>
                            </form>
                        {else}
                            <span class="text-danger">Iscrizione annullata</span>
                            <form action={concat('courses/list/', $course.id)|ezurl()} method="post"
                                  class="d_inline_b">
                                <input type="hidden" name="SubscriptionID" value="{$subscription.object.id}">
                                <input class="btn btn-xs btn-success" type="submit" name="RestoreSubscription"
                                       value="Ripristina iscrizione"/>
                            </form>
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
        Non sono presenti iscrizioni
    </div>
{/if}

{undef $subscriptions $subscriptions_count $count}