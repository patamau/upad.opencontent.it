{* Comment - Full view *}

<div class="content-view-full class-{$node.class_identifier} row">
  
  {include uri='design:nav/nav-section.tpl'}
    
  <div class="content-main">
    
    <h1>{$node.name|wash()}</h1>
    
    <div class="info">
      {include uri='design:parts/date.tpl'}    
      {include uri='design:parts/author.tpl'}
    </div>
    
    <div class="message">
        {$node.data_map.message.content|wash(xhtml)|break|wordtoimage|autolink}
    </div>
    
	
  </div>
  
</div>
