<table class="table header" cellspacing="0" cellpadding="0" border="0"  style="width:100%">
<tbody>
<tr>
    <td style="width: 210px">
	  <img src="{$invoice.ente.data_map.image.content['logoinvoice'].url|ezroot(no,full)}" title="{$invoice.ente.name|wash(xhtml)}" height="100" />
	</td>
    <td>{attribute_view_gui attribute=$invoice.ente.data_map.header_invoice}</td>
</tr>
</tbody>
</table>
<hr />
