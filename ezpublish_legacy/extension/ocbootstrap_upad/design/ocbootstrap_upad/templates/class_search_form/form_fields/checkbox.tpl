{def $is_active = false()}
{foreach $values as $key => $value}
    {if $value.active}{set $is_active = true()}{break}{/if}
{/foreach}
<li {if $is_active}class="active"{/if}>
    <a href="#" class="f_size_large color_dark d_block relative">
        <b>{$label}</b>
        <span class="bg_light_color_1 r_corners f_right color_dark talign_c"></span>
    </a>
    <!--second level-->
    <ul {if $is_active|not}class="d_none"{/if}>
        <li>
            <fieldset class="m_bottom_15 m_top_5">
                {foreach $values as $key => $value}
                    <input type="checkbox" name="{$input_name}[]" id="id-{$value.query}" {if $value.active}checked="checked"{/if} value="{$value.query}" class="d_none"><label for="id-{$value.query}">{$value.name}</label>
                    {delimiter}<br>{/delimiter}
                {/foreach}
            </fieldset>
        </li>
    </ul>
</li>
{undef $is_active}
{*
<div class="form-group">
  {if is_set($label)}<label for="{$id}">{$label}</label>{/if}

  {foreach $values as $value}
	<div class="checkbox">
	  <label>
		<input type="checkbox" class="form-control" name="{$input_name}[]" id="{$id}" {if $value.active}checked="checked"{/if} value="{$value.query}" />
		{$value.name}
	  </label>
	</div>
  {/foreach}
</div>
*}
