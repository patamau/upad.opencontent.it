{* Event - Line view *}

{def $from_year = cond( $node.data_map.from_time.has_content, $node.data_map.from_time.content.timestamp|datetime( custom, '%Y'), false() )
     $from_month = cond( $node.data_map.from_time.has_content, $node.data_map.from_time.content.timestamp|datetime( custom, '%m'), false() )
     $from_day = cond( $node.data_map.from_time.has_content, $node.data_map.from_time.content.timestamp|datetime( custom, '%j'), false() )
     $to_year = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp|datetime( custom, '%Y'), false() )
     $to_month = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp|datetime( custom, '%n'), false() )
     $to_day = cond( $node.data_map.to_time.has_content, $node.data_map.to_time.content.timestamp|datetime( custom, '%j'), false() )
     $same_day = false()
}

{if and( $from_year|eq( $to_year ), $from_month|eq( $to_month ), $from_day|eq( $to_day ) )}
  {set $same_day = true()}
{/if}


<div class="content-view-line class-{$node.class_identifier} media">  
  <div class="class-event {if gt(currentdate() , $node.object.data_map.to_time.content.timestamp)}ezagenda_event_old{/if}">
    <div class="inner">
      <div class="ezagenda_cal">
        <div class="ezagenda_cal_month">{$node.object.data_map.from_time.content.timestamp|datetime(custom,"%M")}</div>
        <div class="ezagenda_cal_day">{$node.object.data_map.from_time.content.timestamp|datetime(custom,"%j")}</div>
      </div>
      <div class="ezagenda_data">
        <h5><a href={$node.url_alias|ezurl}>{attribute_view_gui attribute=$node.data_map.short_title}</a></h5>

        <span class="ezagenda_data_meta">
            {if $same_day}
              {$node.data_map.from_time.content.timestamp|l10n( 'date' )} &middot; Dalle {$node.data_map.from_time.content.timestamp|l10n( 'shorttime' )} alle {$node.data_map.to_time.content.timestamp|l10n( 'shorttime' )}
            {elseif $node.data_map.to_time.has_content}
              Da {$node.data_map.from_time.content.timestamp|l10n( 'shortdatetime' )} a {$node.data_map.to_time.content.timestamp|l10n( 'shortdatetime' )}
            {else}
              {$node.data_map.from_time.content.timestamp|l10n( 'shortdatetime' )}
            {/if}
        </span>
        <p class="ezagenda_abstract">
          {$node.data_map.text.content.output.output_text|oc_shorten(100,'...')}
        </p>

        {if $node.object.data_map.tipologia.has_content}
          <p class="ezagenda_data_type">{attribute_view_gui attribute=$node.data_map.tipologia}</p>
        {/if}

      </div>
    </div>
  </div>
</div>

{undef}