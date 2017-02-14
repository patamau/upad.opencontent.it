var OpenSemanticRefreshing = false;
function triggerOpenSemanticRefresh() {	
    if (OpenSemanticRefreshing) {
        return false;
    }else{
        $( ".action-refreshFromEngine" ).trigger('click');
        return true;
    }
}

$(document).ready(function(){    
    
	function dragAndDrop(){
		$( ".geolocation-edit div.draggable" ).draggable({handle:"span.handler",revert:"invalid",helper: "clone"});
		$( ".geolocation-edit td.droppable" ).droppable({
			accept: ".geolocation-edit div.draggable"
		}).bind( "drop", function( event, ui ){ mergeEntities( ui.draggable, $(this) ); });
		
		$( ".organization-edit div.draggable" ).draggable({handle:"span.handler",revert:"invalid",helper: "clone"});
		$( ".organization-edit td.droppable" ).droppable({
			accept: ".organization-edit div.draggable"		
		}).bind( "drop", function( event, ui ){ mergeEntities( ui.draggable, $(this) ); });
		
		$( ".person-edit div.draggable" ).draggable({handle:"span.handler",revert:"invalid",helper: "clone"});
		$( ".person-edit td.droppable" ).droppable({
			accept: ".person-edit div.draggable"
		}).bind( "drop", function( event, ui ){ mergeEntities( ui.draggable, $(this) ); });
	}
	dragAndDrop();
	
	function mergeEntities( $from, $to ){
		
		var fromAttrID = $from.find( "span.action" ).prop("id" );
		var argArray = fromAttrID.split("-");
		var fromID = argArray[1];
		var objectattributeID = argArray[2];
		var toAttrID = $to.find( "span.action" ).prop("id" );
		argArray = toAttrID.split("-");
		var toID = argArray[1];
		
		$.ez("opensemantic::mergeEntities", {from_entity_id:fromID, to_entity_id:toID, objectattribute_id:objectattributeID }, function(data){
            if (data.error_text != ''){
                console.log(data.error_text);
                return;
            }else{                
            	$from.fadeOut(function(){
        			$from.appendTo( $to ).fadeIn();
        		});
            }
        });
	}
    	
    $(document).on( 'click', ".action-refreshFromEngine", function(e){
        OpenSemanticRefreshing = true;
        tinyMCE.triggerSave();
        var self = $(this);
        var value = self.val();
        self.val('loading...');
        var container = $(this).parents().find( '.visible-entities' );
		container.css( 'opacity', '.4' );
		var id = $(this).prop("id");
        var argArray = id.split("_");
		var data = self.closest( 'form' ).serialize();    	
        var _token = '', _tokenNode = document.getElementById('ezxform_token_js');
        if ( _tokenNode ) _token = '&ezxform_token=' + _tokenNode.getAttribute('title');
        data = data + "&StoreButton=Store draft" + _token;
    	$.post(self.closest( 'form' ).prop('action'), data, function(data) {
    		$.ez("opensemantic::refreshFromEngine", {object_id:argArray[1], object_version:argArray[2], language:argArray[3], objectattribute_id:argArray[4]}, function(data){
    			if (data.error_text != ''){
                    console.log(data.error_text);
                }else{             		
                	$.each( data.content.attributes, function(i,v){
                        if ($( '.visible-entities', $(v.content)).length > 0) {
                            container.html( $( '.visible-entities', $(v.content) ).html() );
                        }
                    });
                }                
                container.css( 'opacity', '1' );
                self.val(value);
                dragAndDrop();
                OpenSemanticRefreshing = false;
    		});
    	});
    	return false;
	});
	
    $(document).on( 'click', ".action-toggleVisibility", function(e){	    
    	var id = $(this).prop("id");
        var argArray = id.split("-");
        var parent = $(this).parent();
        $.ez("opensemantic::toogleVisibility", {entity_id:argArray[1], objectattribute_id:argArray[2]}, function(data){
            if (data.error_text != ''){
                console.log(data.error_text);
                return;
            }else{                
                if(data.content.visibility == 0 ){
                    $(parent).removeClass('visible').addClass('not-visible');
                    $('.action-toggleVisibility', $(parent)).text('+');
                }else{
                    $(parent).removeClass('not-visible').addClass('visible');
                    $('.action-toggleVisibility', $(parent)).text('x');
                }
            }
        });
    });
});
