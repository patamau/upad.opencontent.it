<div class="content-view-line class-{$node.class_identifier} media">   
  <div class="media-body">
	<h4>
	  {$node.name|wash}	  
      <small class="date">{$node.data_map.author.content|wash} - {$node.object.published|l10n(datetime)}</small>
	</h4>

	<div class="attribute-message">
	  <p>{$node.data_map.message.content|wash(xhtml)|break}</p>
	</div>

    </div>
</div>