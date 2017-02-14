<div class="panel panel-info">
    <div class="panel-heading">{"Object info"|i18n("design/standard/content/edit")}</div>
    <div class="panel-body">
	    <p class="menufieldlabel">{"Created"|i18n("design/standard/content/edit")}</p>
	    
        {section show=$object.published}
	    <p class="menufield">{$object.published|l10n(date)}</p>
	    {section-else}
	    <p class="menufield">
	    {"Not yet published"|i18n("design/standard/content/edit")}
	    </p>
	    {/section}
	    
        <p class="menufieldlabel">{"Last Modified"|i18n("design/standard/content/edit")}</p>
	    {section show=$object.modified}
	    <p class="menufield">{$object.modified|l10n(date)}</p>
	    {section-else}
	    <p class="menufield">
	    {"Not yet published"|i18n("design/standard/content/edit")}
	    </p>
	    {/section}
    </div>
</div>

<div class="panel panel-info">
    <div class="panel-heading">{"Sezioni"|i18n("design/standard/content/edit")}</div>
    <div class="panel-body">
        {include uri='design:content/parts/edit_sections.tpl'}
	</div>
</div>

<div class="panel panel-info">
    <div class="panel-heading">{"Versions"|i18n("design/standard/content/edit")}</div>
    <table class="table">
    <tr>
        <td class="menu">
	    <p class="menufieldlabel">{"Editing"|i18n("design/standard/content/edit")}</p>
        </td>
        <td class="menu" width="1">
	    <p class="menufield">{$edit_version}</p>
        </td>
    </tr>
    <tr>
        <td class="menu">
	    <p class="menufieldlabel">{"Current"|i18n("design/standard/content/edit")}</p>
        </td>
        <td class="menu" width="1">
	    <p class="menufield">{$object.current_version}</p>
        </td>
    </tr>
    <tr>
        <td class="menu" colspan="2" align="right">
          <input class="menubutton" type="submit" name="VersionsButton" value="{'Manage'|i18n('design/standard/content/edit')}" />
        </td>
    </tr>
    </table>
</div>

<div class="panel panel-info">
    <div class="panel-heading">{"Translations"|i18n("design/standard/content/edit")}</div>
    <table class="table">
    <tr>
        <td>
            <p class="menufieldlabel">{'No translation'|i18n( 'design/standard/content/edit' )}</p>
        </td>
        <td>
            <input type="radio" name="FromLanguage" value=""{if $from_language|not} checked="checked"{/if}{if $object.status|eq(0)} disabled="disabled"{/if} />
        </td>
    </tr>
    {if $object.status}
        {foreach $object.languages as $language}
        <tr>
            <td>
                <p class="menufieldlabel">{$language.name|wash}</p>
            </td>
            <td>
                <input type="radio" name="FromLanguage" value="{$language.locale}"{if $language.locale|eq($from_language)} checked="checked"{/if} />
            </td>
        </tr>
        {/foreach}
    {/if}

    <tr>
        <td colspan="2" align="right">
            <input class="menubutton" type="submit" name="FromLanguageButton" value="{'Translate'|i18n( 'design/standard/content/edit' )}" />
        </td>
    </tr>
    </table>
</div>    
{*
<div class="panel panel-info">
    <div class="panel-heading">{"Related objects"|i18n("design/standard/content/edit")}</div>
    <table class="table">
    {section name=Object loop=$related_contentobjects sequence=array(bglight,bgdark)}
    <tr>
        <td class="{$Object:sequence}" align="left" colspan="1">
            <p class="box">{node_view_gui view=thumb content_node=$Object:item.main_node}</p>
            <span class="small">&lt;object id='{$Object:item.id}' /&gt;</span>
    	</td>
        <td class="{$Object:sequence}" align="right" colspan="1" width="1">
            <input type="checkbox" name="DeleteRelationIDArray[]" value="{$Object:item.id}" />
        </td>
    </tr>
    {/section}
    <tr>
        <td align="right" colspan="2">
          <div class="buttonblock">
            <input class="menubutton" type="image" name="BrowseObjectButton" value="{'Find'|i18n('design/standard/content/edit')}" src={"find.png"|ezimage} />
            {section show=$related_contentobjects}
            <input class="menubutton" type="image" name="DeleteRelationButton" value="{'Remove'|i18n('design/standard/content/edit')}" src={"trash.png"|ezimage} />
            {/section}
          </div>
        </td>
    </tr>
    <tr>
        <td colspan="2" align="right">	
            <select	name="ClassID" class="classcreate">
                {section name=Classes loop=$object.can_create_class_list}
                <option value="{$Classes:item.id}">{$Classes:item.name}</option>
                {/section}
            </select>
            <input class="menubutton" type="submit" name="NewButton" value="{'New'|i18n('design/standard/content/edit')}" />
            <input type="hidden" name="SectionID" value="{$object.section_id}" />
        </td>
    </tr>	
    </table>
</div>
*}