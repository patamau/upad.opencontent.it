{def $showStateForm = false()}
{foreach $current_node.object.allowed_assign_state_list as $allowed_assign_state_info}
    {if $allowed_assign_state_info.group.identifier|eq( 'share' )}
        {foreach $allowed_assign_state_info.states as $state}
            {if $current_node.object.state_id_array|contains($state.id)|not()}
                {set $showStateForm = true()}
            {/if}
        {/foreach}
        {if $showStateForm}
        <div class="dropdown pull-left">
            {foreach $allowed_assign_state_info.states as $state}
            {if $current_node.object.state_id_array|contains($state.id)}
                <a class="btn btn-sm" data-toggle="dropdown" href="#">
                    {switch match=$state.identifier}
                        {case match="protected"}<i class="icon-unlock-alt"></i> {/case}
                        {case match="private"}<i class="icon-lock"></i> {/case}
                        {case match="public"}<i class="icon-unlock"></i> {/case}
                        {case}{/case}
                    {/switch}
                    {$state.current_translation.name|wash} <b class="caret"></b>
                </a>
            {/if}
            {/foreach}
            <ul class="dropdown-menu" role="menu" aria-labelledby="dLabel">
            {foreach $allowed_assign_state_info.states as $state}
                {if $current_node.object.state_id_array|contains($state.id)|not()}
                <li role="presentation">
                    <a href="{concat('/assign/state/',$state.id,'/',$current_node.object.id)|ezurl(no)}" tabindex="-1" role="menuitem">
                        {switch match=$state.identifier}
                            {case match="protected"}<i class="icon-unlock-alt"></i> {/case}
                            {case match="private"}<i class="icon-lock"></i> {/case}
                            {case match="public"}<i class="icon-unlock"></i> {/case}
                            {case}{/case}
                        {/switch}
                        {$state.current_translation.name|wash}
                    </a>
                </li>
                {/if}
            {/foreach}
            </ul>
        </div>
        {/if}
    {/if}
{/foreach}