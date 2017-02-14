{if not( is_set( $self_edit ) )}
    {def $self_edit=false()}
{/if}

{if not( is_set( $self_delete ) )}
    {def $self_delete=false()}
{/if}

{def $can_edit=fetch( 'comment', 'has_access_to_function', hash( 'function', 'edit',
                                                                        'contentobject', $contentobject,
                                                                        'language_code', $language_code,
                                                                        'comment', $comment,
                                                                        'scope', 'role',
                                                                        'node', $node ) )
            $can_delete=fetch( 'comment', 'has_access_to_function', hash( 'function', 'delete',
                                                                          'contentobject', $contentobject,
                                                                          'language_code', $language_code,
                                                                          'comment', $comment,
                                                                          'scope', 'role',
                                                                          'node', $node ) )
            $user_display_limit_class=concat( ' class="limitdisplay-user limitdisplay-user-', $comment.user_id, '"' )}
            

<div class="row comment-item">
    <div class="col-xs-12 comment-text" style="margin-bottom: 20px">
        
        <div class="popover" style="display: block; position: static; max-width: none">
        
        <h3 class="popover-title">    
        {if $comment.title}{$comment.title|wash}{/if}            
        {if $comment.name}
          {if $comment.url|eq( '' )}
              <small>{$comment.name|wash}</small>
          {else}
              <a href="{$comment.url|wash}"><small>{$comment.name|wash}</small></a>
          {/if}
        {elseif $comment.user_id}
            <small>{fetch( content, object, hash( object_id, $comment.user_id )).name|wash()}</small>
        {/if}
        
        </h3> 
            
            <div class="popover-content">
                
                {if or( $can_edit, $can_self_edit, $can_delete, $can_self_delete )}
                <div class="comment-controls pull-right">
                   {if or( $can_edit, $can_self_edit )}
                       {if and( $can_self_edit, not( $can_edit ) )}
                           {def $displayAttribute=$user_display_limit_class}
                       {else}
                           {def $displayAttribute=''}
                       {/if}
                       <span{$displayAttribute}>
                           <a href={concat( '/comment/edit/', $comment.id )|ezurl}><span class="glyphicon glyphicon-edit"></span></a>
                       </span>
                       {undef $displayAttribute}
                   {/if}
                   {if or( $can_delete, $can_self_delete )}
                       {if and( $can_self_delete, not( $can_delete ) )}
                           {def $displayAttribute=$user_display_limit_class}
                       {else}
                           {def $displayAttribute=''}
                       {/if}
                       <span {$displayAttribute}>
                           <a href={concat( '/comment/delete/',$comment.id )|ezurl}>
                               <span class="glyphicon glyphicon-trash"></span>
                           </a>
                       </span>
                       {undef $displayAttribute}
                   {/if}
                </div>
                {/if}
                
                <small>{$comment.created|l10n( 'shortdatetime' )}</small>
                
                <p>{$comment.text|wash|nl2br}</p>
            </div>
        </div>

    </div>
</div>

       {undef $can_edit $can_delete}