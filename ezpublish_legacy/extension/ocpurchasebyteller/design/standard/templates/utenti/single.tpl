
<div class="container">
    <h1 class="m_bottom_20">{attribute_view_gui attribute=$user.data_map.first_name} {attribute_view_gui attribute=$user.data_map.last_name}</h1>
    <div class="row clearfix">
        <div class="col-lg-6 col-md-6 col-sm-6 m_xs_bottom_30">
            <table class="description_table m_bottom_5">
                <tbody>
                    {foreach $user.contentobject_attributes as $attribute max 7}
                        <tr>
                            <td>{$attribute.contentclass_attribute_name}</td>
                            <td><strong class="color_dark">{attribute_view_gui attribute=$attribute}</td>
                        </tr>
                    {/foreach}
                </tbody>
            </table>
        </div>

        <div class="col-lg-6 col-md-6 col-sm-6 m_xs_bottom_30">
            <table class="description_table m_bottom_5">
                <tbody>
                {foreach $user.contentobject_attributes as $attribute offset 7}
                    <tr>
                        <td>{$attribute.contentclass_attribute_name}</td>
                        <td><strong class="color_dark">{attribute_view_gui attribute=$attribute}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
        </div>
    </div>

    <hr/>

    {def $page_limit = 50
    $subscriptions = fetch(
    'content', 'tree', hash(
    parent_node_id, 1,
    class_filter_type, 'include',
    class_filter_array, array( 'subscription' ),
    limit, $page_limit,
    offset, $view_parameters.offset,
    attribute_filter, array(
    array( 'subscription/user', '=', $user.id )
    ),
    sort_by, array(
    array('attribute', true(), 'subscription/annullata'),
    array( 'published', true() )
    )
    )
    )

    $subscriptions_count = fetch(
    'content', 'tree_count', hash(
    parent_node_id, 1,
    attribute_filter, array(
    array( 'subscription/user', '=', $user.id )
    ),
    class_filter_type, 'include',
    class_filter_array, array( 'subscription' )
    )
    )

    $count = sum($view_parameters.offset, 1)}


    <h2>Lista iscrizioni</h2>

    {if $subscriptions_count|gt(0)}
        <table class="table table-striped m_top_20">
            <tr>
                <th><strong>#</strong></th>
                <th><strong>Data</strong></th>
                <th><strong>Corso</strong></th>
                <th><strong>Ricevute</strong></th>
            </tr>
            {foreach $subscriptions as $subscription}
                <tr{if eq($subscription.data_map.annullata.content, 1)} class="danger"{/if}>
                    <td>{$count}</td>
                    <td>{$subscription.object.published|l10n(shortdate)}</td>
                    <td>
                        {$subscription.data_map.course.content.name|wash()}
                    </td>
                    <td>
                        {foreach $subscription.data_map.invoices.content.rows.sequential as $row}
                            {def $invoice = fetch( courses, invoice, hash( 'id', $row.columns[0] ))}
                            <ul class="list-inline">
                                <li><a class="btn btn-xs btn-danger" href={concat("layout/set/pdf/invoice/view/",$invoice.id)|ezurl()}>Stampa</a></li>
                                <li><strong>Nr:</strong> {$invoice.invoice_id}</li>
                                <li><strong>Data:</strong> {$invoice.date|l10n(shortdate)}</li>
                                <li><strong>Importo:</strong> {$invoice.total|l10n( 'currency' )}</li>
                            </ul>
                            {undef $invoice}
                        {/foreach}
                    </td>
                </tr>
                {set $count = $count|sum(1)}
            {/foreach}
        </table>
        {include name=navigator
        uri='design:navigator/google.tpl'
        page_uri= concat('courses/list/', $user.id)
        item_count=$subscriptions_count
        view_parameters=$view_parameters
        item_limit=$page_limit}
    {else}
        <div class="alert alert-info m_top_20">
            Non sono presenti iscrizioni
        </div>
    {/if}

    {undef $subscriptions $subscriptions_count $count}


</div>


