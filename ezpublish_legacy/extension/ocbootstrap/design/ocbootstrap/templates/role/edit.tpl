<div class='page-header'>      
    <h1>{"Role edit %1"|i18n("design/standard/role",,array($role.name|wash))}</h1>   
</div>
<div class='row'>
    <div class="col-sm-12">

        <form action={concat($module.functions.edit.uri,"/",$role.id,"/")|ezurl} method="post" >
        
        <div class="block">
            <label>{"Name"|i18n("design/standard/role")}</label><div class="labelbreak"/>
            <input class="box form-control" type="edit" name="NewName" value="{$role.name|wash}" />
        </div>
        
        <h2>{"Current policies"|i18n("design/standard/role")}</h2>
        
        <table class="list" width="100%" cellspacing="0" cellpadding="0" border="0">
        <tr>
            <th width="10%">{"Module"|i18n("design/standard/role")}</th>
            <th width="10%">{"Function"|i18n("design/standard/role")}</th>
            <th width="79%">{"Limitations"|i18n("design/standard/role")}</th>
            <th>{"Edit"|i18n("design/standard/role")}</th>
            <th>{"Remove"|i18n("design/standard/role")}</th>
        </tr>
        {section name=Policy loop=$policies sequence=array(bglight,bgdark) }
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
                      {$Policy:Limitation:item.identifier}(
                      {section name=LimitationValues loop=$Policy:Limitation:item.values_as_array_with_names}
                          {$Policy:Limitation:LimitationValues:item.Name}
                          {delimiter}, {/delimiter}
                      {/section})
                      {delimiter}, {/delimiter}
                  {/section}  
                {section-else}
                  *
                {/section}
            </td> 
            <td align="center" width="1">
                <a href={concat("role/policyedit/",$Policy:item.id)|ezurl} title="{'Edit policy'|i18n('design/standard/role')}">
                    <i class="icon-edit"></i>
                </a>
            </td>
            <td align="center" width="1">
                <input type="checkbox" name="DeleteIDArray[]" value="{$Policy:item.id}" />
            </td>
        </tr>
        {/section}  
        <tr>
            <td colspan="4">
                <input class="button" type="submit" name="CreatePolicy" value="{'New'|i18n('design/standard/role')}" />
            </td>
            <td align="center" width="1">                
                <button type="submit" name="RemovePolicies" value="{'Remove'|i18n('design/standard/role')}" title="{'Remove selected policies'|i18n('design/standard/role')}" class="btn btn-link"><i class="icon-trash"></i></button>
            </td>
        </tr>
        </table>
        
        <hr />
        <div class="buttonblock">
            <input class="defaultbutton" type="submit" name="Apply" value="{'Store'|i18n('design/standard/role')}" />
            <input class="button" type="submit" name="Discard" value="{'Discard changes'|i18n('design/standard/role')}" />
        </div>
        
        
        </form>
    </div>
</div>
