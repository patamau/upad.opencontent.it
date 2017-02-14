<li {if $value}class="active"{/if}>
    <a href="#" class="f_size_large color_dark d_block relative">
        <b>{$label}</b>
        <span class="bg_light_color_1 r_corners f_right color_dark talign_c"></span>
    </a>
    <!--second level-->
    <ul {if eq($value, '')}class="d_none"{/if}>
        <li>
            <fieldset class="m_bottom_15 m_top_5">
                <input type="text" class="form-control" name="{$input_name}" id="{$id}" {if and( is_set($label)|not, is_set($placeholder) )}placeholder="{$placeholder}"{/if} value="{$value}">
            </fieldset>
        </li>
    </ul>
</li>

{*
<div class="form-group">
  {if is_set($label)}<label for="{$id}">{$label}</label>{/if}
  <input type="text" class="form-control" name="{$input_name}" id="{$id}" {if and( is_set($label)|not, is_set($placeholder) )}placeholder="{$placeholder}"{/if} value="{$value}">
</div>
*}
