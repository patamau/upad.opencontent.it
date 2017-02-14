<div class='page-header'>      
    <h1>{"Role list"|i18n("design/standard/role")}</h1>    
</div>
<div class='row'>
    <div class="col-sm-12">
        
    <form action={concat($module.functions.list.uri,"/")|ezurl} method="post" >
    
    <table class="table" width="100%" cellspacing="0" cellpadding="0" border="0">
    
    {foreach $roles as $role sequence array( 'bglight', 'bgdark' ) as $style}
    {if $role.name|begins_with('_')|not()}
    <tr>
        <td class="{$style}"><a href={concat("/role/view/",$role.id)|ezurl}>{$role.name}</a></td>
        <td width="1%" class="{$style}">
            <a href={concat("/role/edit/",$role.id)|ezurl} title="{'Edit role'|i18n('design/standard/role')}">
                <i class="icon-edit"></i>
            </a>
        </td>
        <td width="1%" class="{$style}">
            <a href={concat("/role/copy/",$role.id)|ezurl} title="{'Copy role'|i18n('design/standard/role')}">
                <i class="icon-copy"></i>
            </a>
        </td>
        <td width="1%" class="{$style}">
            <a href={concat("/role/assign/",$role.id)|ezurl} title="{'Assign role to user or group'|i18n('design/standard/role')}">
                <i class="icon-share-alt"></i>
            </a>
        </td>
        <td width="1%" class="{$style}" align="center">
            <input type="checkbox" name="DeleteIDArray[]" value="{$role.id}" />
        </td>
    </tr>
    {/if}
    {/foreach}
    <tr>
        <td colspan="4"><input class="button" type="submit" name="NewButton" value="{'New'|i18n('design/standard/role')}" /></td>
        <td align="right" width="1%">
            <button type="submit" name="RemoveButton" value="{'Remove'|i18n('design/standard/role')}" title="{'Remove selected roles'|i18n('design/standard/role')}" class="btn btn-link"><i class="icon-trash"></i></button>
        </td>
    </tr>
    </table>
    
    {include name=navigator
             uri='design:navigator/google.tpl'
             page_uri='/role/list'
             item_count=$role_count
             view_parameters=$view_parameters
             item_limit=$limit}
    
    </form>
    
    </div>
</div>
