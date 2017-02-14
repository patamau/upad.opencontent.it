<div class="row">
<div class="col-sm-12">
  <div class="box">
    <div class="box-content">
      <h4>
        <a class="text-contrast" href="{$node.url_alias|ezurl('no')}" title="{$node.name|wash()}">{$node.name|wash()}</a>
        <small>{$node.object.published|l10n(date)} - {$node.class_name}</small>
      </h4>
      <a href={$node.url_alias|ezurl()}><small>{$node.path_with_names}</small></a>
      <p>{$node.highlight}</p>
    </div>
  </div>
</div>
</div>