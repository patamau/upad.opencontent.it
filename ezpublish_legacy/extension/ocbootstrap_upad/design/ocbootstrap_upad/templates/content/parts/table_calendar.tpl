{*
timestamp=$temp_ts
calendar=$event_node
events=$events
*}

{def $curr_ts = currentdate()
     $curr_today = $curr_ts|datetime( custom, '%j')
     $curr_year = $curr_ts|datetime( custom, '%Y')
     $curr_month = $curr_ts|datetime( custom, '%n')
     $temp_month = $timestamp|datetime( custom, '%n')
     $temp_year = $timestamp|datetime( custom, '%Y')
     $temp_today = $timestamp|datetime( custom, '%j')
     $days = $timestamp|datetime( custom, '%t')
     $first_ts = makedate($temp_month, 1, $temp_year)    
     $last_ts = makedate($temp_month, $days, $temp_year)
     $dayone = $first_ts|datetime( custom, '%w' )
     $daylast = $last_ts|datetime( custom, '%w' )
     $span1 = $dayone
     $span2 = sub( 7, $daylast )
     $dayofweek = 0
     $url_reload=concat( $calendar.url_alias, "/(day)/", $temp_today, "/(month)/", $temp_month, "/(year)/", $temp_year, "/offset/2")
     $url_back=concat( $calendar.url_alias,  "/(month)/", sub($temp_month, 1), "/(year)/", $temp_year)
     $url_forward=concat( $calendar.url_alias, "/(month)/", sum($temp_month, 1), "/(year)/", $temp_year)
     $day_array = " "
     $loop_dayone = 1
     $loop_daylast = 1
}

{if eq($temp_month, 1)}
    {set $url_back=concat( $calendar.url_alias,"/(month)/", "12", "/(year)/", sub($temp_year, 1))}
{elseif eq($temp_month, 12)}
    {set $url_forward=concat( $calendar.url_alias,"/(month)/", "1", "/(year)/", sum($temp_year, 1))}
{/if}
    
{foreach $events as $event}
    {if eq($temp_month|int(), $event.data_map.from_time.content.month|int())}
        {set $loop_dayone = $event.data_map.from_time.content.day}
    {else}
        {set $loop_dayone = 1}
    {/if}
    {if $event.data_map.to_time.content.is_valid}
       {if eq($temp_month|int(), $event.data_map.to_time.content.month|int())}
            {set $loop_daylast = $event.data_map.to_time.content.day}
        {else}
            {set $loop_daylast = $days}
        {/if}
    {else}
         {set $loop_daylast = $loop_dayone}
    {/if}
    {for $loop_dayone|int() to $loop_daylast|int() as $counter}
        {set $day_array = concat($day_array, $counter, ', ')}        
    {/for}    
{/foreach}

<div class="table-responsive">
    <table class="table table-calendar" summary="Calendario degli eventi">
        <thead>
            <tr class="calendar_heading">
                <th class="calendar_heading_prev"><a href={$url_back|ezurl} title=" Previous month ">&lt;</a></th>
                <th class="calendar_heading_date" colspan="5">{$timestamp|datetime( custom, '%F' )|upfirst()}&nbsp;{$temp_year}</th>
                <th class="calendar_heading_next"><a href={$url_forward|ezurl} title=" Next Month ">&gt;</a></th>
            </tr>
            <tr class="calendar_heading_days">
                <th class="first_col">L</th>
                <th>M</th>
                <th>M</th>
                <th>G</th>
                <th>V</th>
                <th>S</th>                
                <th class="last_col">D</th>
            </tr>
        </thead>
        <tbody>

            {def $counter=1
                 $col_counter=1
                 $css_col_class=''
                 $col_end=0}
            
            {while le( $counter, $days )}
                {set $dayofweek = makedate( $temp_month, $counter, $temp_year )|datetime( custom, '%w' )
                     $css_col_class = ''
                     $col_end       = or( eq( $dayofweek, 0 ), eq( $counter, $days ) )}
                {if or( eq( $counter, 1 ), eq( $dayofweek, 1 ) )}
                    <tr class="days{if eq( $counter, 1 )} first_row{elseif lt( $days|sub( $counter ), 7 )} last_row{/if}">
                    {set $css_col_class=' first_col'}
                {elseif and( $col_end, not( and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne( 7 ) ) ) )}
                    {set $css_col_class=' last_col'}
                {/if}
                {if and( $span1|gt( 1 ), eq( $counter, 1 ) )}
                    {set $col_counter=1 $css_col_class=''}
                    {while ne( $col_counter, $span1 )}
                        <td>&nbsp;</td>
                        {set $col_counter=inc( $col_counter )}
                    {/while}
                {elseif and( eq($span1, 0 ), eq( $counter, 1 ) )}
                    {set $col_counter=1 $css_col_class=''}
                    {while le( $col_counter, 6 )}
                        <td>&nbsp;</td>
                        {set $col_counter=inc( $col_counter )}
                    {/while}
                {/if}
                <td class="{$css_col_class}{if $day_array|contains(concat(' ', $counter, ',')) } active{/if} {if and(eq($counter, $curr_today), eq($curr_month, $temp_month))} today{/if}">
                {if $day_array|contains(concat(' ', $counter, ',')) }
                    <a href={concat( $calendar.url_alias, "/(day)/", $counter, "/(month)/", $temp_month, "/(year)/", $temp_year)|ezurl}>
                        {if eq($counter, $temp_today)}<strong>{$counter}</strong>{else}{$counter}{/if}
                    </a>
                {else}
                    {if eq($counter, $temp_today)}<strong><span>{$counter}</span></strong>{else}<span>{$counter}</span>{/if}
                {/if}
                </td>
                {if and( eq( $counter, $days ), $span2|gt( 0 ), $span2|ne(7))}
                    {set $col_counter=1}
                    {while le( $col_counter, $span2 )}
                        {set $css_col_class=''}
                        {if eq( $col_counter, $span2 )}
                            {set $css_col_class=' last_col'}
                        {/if}
                        <td class="{$css_col_class}">&nbsp;</td>
                        {set $col_counter=inc( $col_counter )}
                    {/while}
                {/if}
                {if $col_end}
                    </tr>
                {/if}
                {set $counter=inc( $counter )}
            {/while}
        </tbody>
    </table>
</div>