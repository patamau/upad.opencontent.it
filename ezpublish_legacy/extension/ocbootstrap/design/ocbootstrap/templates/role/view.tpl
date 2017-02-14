<div class='page-header'>      
    <h1>{"Role edit %1"|i18n("design/standard/role",,array($role.name|wash))}</h1>   
</div>
<div class='row'>
    <div class="col-sm-12">
        
        <form action={concat($module.functions.view.uri,"/",$role.id,"/")|ezurl} method="post" >
        
        <div class="objectheader">
            <h2>{"Role"|i18n("design/standard/role")}</h2>
        </div>
        <div class="object">
            <strong>{"Name"|i18n("design/standard/role")}:</strong> {$role.name|wash}            
            <button class="button" type="submit" name="EditRoleButton" value="{'Edit'|i18n('design/standard/role')}" title="{'Edit current role'|i18n('design/standard/role')}">
                <i class="icon-edit"></i> {'Edit current role'|i18n('design/standard/role')}
            </button>
        </div>
        
        <h2>{"Role policies"|i18n("design/standard/role")}</h2>
        
        <table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <th>{"Module"|i18n("design/standard/role")}</th>
            <th>{"Function"|i18n("design/standard/role")}</th>
            <th>{"Limitation"|i18n("design/standard/role")}</th>
        </tr>
        
        {section name=Policy loop=$policies sequence=array(bglight,bgdark)}
        <tr class="{$:sequence}">
            <td>
                {$Policy:item.module_name}
            </td>
            <td>
                {$Policy:item.function_name}
            </td>
            <td>
                {section show=$Policy:item.limitations}
                  {section name=Limitation loop=$Policy:item.limitations}
                      {$Policy:Limitation:item.identifier|wash}(
                      {section name=LimitationValues loop=$Policy:Limitation:item.values_as_array_with_names}
                          {$Policy:Limitation:LimitationValues:item.Name|wash}
                          {delimiter}, {/delimiter}
                      {/section})
                      {delimiter}, {/delimiter}
                  {/section}
                {section-else}
              *
                {/section}
            </td>
        </tr>
        {/section}
        </table>
        
        <h2>{"Users and groups assigned to this role"|i18n("design/standard/role")}</h2>
        
        <table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <th width="79%">{"User"|i18n("design/standard/role")}</th>
            <th width="20%">{"Limitation"|i18n("design/standard/role")}</th>
            <th width="1">&nbsp;</th>    
        </tr>
        {foreach $user_array as $user sequence array(bglight,bgdark) as $style}
        <tr>
            <td class="{$style}">
                {$user.user_object.content_class.identifier|class_icon( 'small', $user.user_object.content_class.name )}&nbsp;{$user.user_object.name|wash}
            </td>
            <td class="{$style}">
                {if $user.limit_ident}
                  {$user.limit_ident|wash}( {$user.limit_value|wash} )
                {/if}
            </td>
            <td width="1%" class="{$style}" align="center">
                <input type="checkbox" value="{$user.user_role_id}" name="IDArray[]" />
            </td>
        </tr>
        {/section}
        <tr>
            <td>
                <p><input class="button" type="submit" name="AssignRoleButton" value="{'Assign'|i18n('design/standard/role')}" title="{'Assign role to user or group'|i18n('design/standard/role')}" /></p>
                <p>
                <input class="button" type="submit" name="AssignRoleLimitedButton" value="{'Assign limited'|i18n('design/standard/role')}" title="{'Assign role to user or group'|i18n('design/standard/role')}" />
                <label><input type="radio" name="AssignRoleType" value="subtree" checked> {"Subtree"|i18n( 'design/standard/role' )}</label>
                <label><input type="radio" name="AssignRoleType" value="section"> {"Section"|i18n( 'design/standard/role' )}</label>
                </p>
            </td>
            <td>
              &nbsp;
            </td>
            <td width="1%" align="center">
                <button class="btn btn-link icon-trash" type="submit" name="RemoveRoleAssignmentButton" value="{'Remove'|i18n('design/standard/role')}" title="{'Remove selected assignments'|i18n('design/standard/role')}" />
            </td>
        </tr>
        </table>
        
        </form>
    </div>
</div>