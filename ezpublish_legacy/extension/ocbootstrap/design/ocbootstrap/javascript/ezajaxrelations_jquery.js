jQuery(function( $ )
{
    // Attache click event to search button and show input fields
    $('.ezobject-relation-search-btn').click( _search ).removeClass('hide');

    // Attache key press event to catch enter and show input fields
    $('input.ezobject-relation-search-text').keypress( function( e ){
        if ( e.which == 13 ){
            return _search.call( this, e );
        }
    }).removeClass('hide');

    // Function handling search event
    function _search( e )
    {
        e.preventDefault();
        var box = $(this).parents( '.relations-searchbox' ), text = box.find('input.ezobject-relation-search-text');
        if ( text.val() )
        {
            var params = { 'CallbackID': box.attr('id'), 'EncodingFetchSection': 1 };
            var node = box.find("*[name*='_for_object_start_node']"), classes = box.find("input[name*='_for_object_class_constraint_list']");
            if ( node.size() ) params['SearchSubTreeArray'] = node.val();
            if ( classes.size() ) params['SearchContentClassIdentifier'] = classes.val();
            $.ez( 'ezjsc::search::' + text.val(), params, function( data ){                
                if ( data && data.content !== '' )
                {                    
                    var boxElem = $( 'div.ezobject-relation-search-browse', box  );
                    if ( data.content.SearchResultCount > 0 )
                    {
                        boxElem.empty();
                        var arr = data.content.SearchResult, pub = $('#ezobjectrelation-search-published-text');
                        for ( var i = 0, l = arr.length; i < l; i++ )
                        {
                            var aElem = $( '<a></a>' );
                            aElem.bind( 'click', { table: box.find('table'),
                                                   id: arr[i].id,
                                                   name: arr[i].name,
                                                   className: arr[i].class_name,
                                                   sectionName: arr[i].section.name,
                                                   publishedTxt: pub.val() }, function(e) {                                
                                ezajaxrelationsSearchAddObject( this, $(e.currentTarget).parents('.relations-searchbox').find('table'), e.data.id, e.data.name, e.data.className, e.data.sectionName, e.data.publishedTxt );
                            } );
                            aElem.append( arr[i].name );
                            aElem.attr( 'title', arr[i].path_identification_string );
                            var pElem = $("<p></p>");
                            pElem.append( aElem );
                            boxElem.append( pElem );                            
                        }
                        boxElem.removeClass('hide');
                    }
                    else
                    {
                        var html = '<p class="ezobjectrelation-search-empty-result">' + $('#ezobjectrelation-search-empty-result-text').html().replace( '--search-string--', '<em>' + data.content.SearchString + '<\/em>' ) + '<\/p>';
                        boxElem.html( html ).removeClass('hide');
                    }
                }
                else
                {
                    alert( data.content.error_text );
                }
            });
        }
    }

    // function for selecting a search result object
    function _addObject( link, $table, id, name, className, sectionName, publishedTxt )
    {        
        link.onclick = function(){return false;};
        link.className = 'disabled';
        var $baseTr = $( 'tbody tr.hide', $table );        
        var tr  = $baseTr.clone();
        tr.insertBefore( $baseTr );
        var tds = $('td',tr).slice( 0 );
        tds.eq( 0 ).find('input').val( id );
        tds.eq( 1 ).find('small').html( name );
        tds.eq( 2 ).find('small').html( className );
        tds.eq( 3 ).find('small').html( sectionName );
        tds.eq( 4 ).find('small').html( publishedTxt );
        tds.eq( 5 ).find('small').val( $('tbody tr').length - 1 );        
        tr.removeClass('hide');      
        $table.removeClass('hide');
        $table.parents().find('.ezobject-relation-remove-button').removeClass('hide');
        $table.parents().find('.ezobject-relation-no-relation').addClass('hide');
    }

    // register searchAdd gloablly as it is used on search links
    window.ezajaxrelationsSearchAddObject = _addObject;
});
