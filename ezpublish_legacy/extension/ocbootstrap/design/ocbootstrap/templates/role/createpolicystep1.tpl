<div class='page-header'>      
    <h1>{"Create policy for"|i18n("design/standard/role")} {$role.name}</h1>
</div>
<div class='row'>
    <div class="col-sm-12">
        
        <form action={concat($module.functions.edit.uri,"/",$role.id,"/")|ezurl} method="post" >
        
        <h2>{"Step 1"|i18n("design/standard/role")}</h2>
        <div class="block">
        <label>{"Give access to module"|i18n("design/standard/role")}</label><div class="labelbreak"></div>
            <select class="form-control" name="Modules" size="1">
            <option value="*">{"Every module"|i18n("design/standard/role")}</option>
            {section name=All loop=$modules }
              <option value="{$All:item}">{$All:item}</option>
            {/section}
            </select>
        </div>
        
        <hr />
        
        <div class="buttonblock">
        <input class="button" type="submit" name="AddModule" value="{'Allow all'|i18n('design/standard/role')}" />
        <input class="button" type="submit" name="CustomFunction" value="{'Allow limited'|i18n('design/standard/role')}" />
        </div>
        <div class="buttonblock">
        <input class="button" type="submit" value="{'Cancel'|i18n('design/standard/role')}" />
        </div>
        
        </form>
    </div>
</div>
