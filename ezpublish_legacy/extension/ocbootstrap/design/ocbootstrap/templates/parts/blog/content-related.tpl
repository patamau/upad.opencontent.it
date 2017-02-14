<div class="content-related">

  <div class="tag-cloud">
    {eztagcloud( hash( 'class_identifier', 'blog_post',
                       'parent_node_id', $used_node.node_id ) )}
  </div>

  <div class="tags">      
      {foreach ezkeywordlist( 'blog_post', $used_node.node_id ) as $keyword}
        <a href={concat( $used_node.url_alias, "/(tag)/", $keyword.keyword|rawurlencode )|ezurl} title="{$keyword.keyword}">
          <span class="label label-primary">{$keyword.keyword} ({fetch( 'content', 'keyword_count', hash( 'alphabet', $keyword.keyword, 'classid', 'blog_post','parent_node_id', $used_node.node_id ) )})</span>
        </a>        
      {/foreach}      
  </div>
  
  <div class="archive">
      {foreach ezarchive( 'blog_post', $used_node.node_id ) as $archive}
          <a href={concat( $used_node.url_alias, "/(month)/", $archive.month, "/(year)/", $archive.year )|ezurl} title="">
            <span class="label label-default">{$archive.timestamp|datetime( 'custom', '%F %Y' )}</span>
          </a>
      {/foreach}
  </div>
  
  {include uri='design:parts/blog/calendar.tpl'}

  
</div>