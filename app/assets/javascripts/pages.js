var Weakly = {
	
	hashMatch: function(){
		
		function checkHash(value) {
		  var md5_regex = /^[0-9a-f]{32}$/
		  var sha1_regex = /^[0-9a-f]{40}$/
		  var sha256_regex = /^[0-9a-f]{64}$/
		  var fuzzy_regex = /^[0-9]+:[^:]+:[^:]+$/

			if(value.match(md5_regex))
			{
				console.log('MD5 match');
			}
			else if(value.match(sha1_regex))
			{
				console.log('SHA1 match');
			}
			else if(value.match(sha256_regex))
			{
				console.log('SHA256 match');
			}
			else if(value.match(fuzzy_regex))
			{
				
				$('input.hash-type').val('fuzzy_hash');
				
				$('div#search-inital-text').fadeOut('fast', function() {
					$('div.helper-placeholder').show();
				});
				$('div#fuzzy-hash-options').fadeIn('slow');
			} else {
				
				if ($('div.hash-match-options').is(':visible')) {
					$('div.hash-match-options').fadeOut('slow', function() {
						$('div.helper-placeholder').show();
						$('div#search-inital-text').fadeIn('slow');
					});

				}
			}
			
		};
		
		function hideDisplay() {
			
		};
		
		$('input#hash').keypress(function(event) { checkHash($(this).val()); });
		$('input#hash').change(function(event) { checkHash($(this).val()); });
		$('input#hash').live('input paste', function(){ checkHash($(this).val()); });
		
	},
	
	handleSlider: function(){
		$("#slider-range").slider({
			range: true,
			min: 0,
			max: 100,
			values: [ 50, 100 ],

			slide: function( event, ui ) {
				$("#tolerance").val( ui.values[ 0 ] + "% - " + ui.values[ 1 ] + "%" );
			}
		});

		$("input#tolerance").val(  $( "#slider-range" ).slider( "values", 0 ) +
		"% - " + $( "#slider-range" ).slider( "values", 1 ) + "%" );
	}
	
}


$(document).ready(function() {
	
	Weakly.hashMatch();
	Weakly.handleSlider();
	$('a.new-hash').fancybox({padding: 0});
	
	$('input#hash').focus(function(event) {
		$('button.new-hash').fadeOut('fast');
		$('h1#or').fadeOut('fast', function() {
			$('input#hash').animate({'width': '735px'}, 300);
			if ($('div.hash-match-options').is(':hidden')) {
				$('div.helper-placeholder').hide();
				$('div#search-inital-text').fadeIn('slow');
			};
			
				
		});
		

	});
	
	$('input#hash').blur(function(event) {
		if ($(this).val() == "") {
			$(this).animate({'width': '466px'}, 300, function() {
			  	$('button.new-hash').fadeIn('fast');
				$('h1#or').fadeIn('fast');
				$('div#search-inital-text').fadeOut('fast', function() {
					$('div.helper-placeholder').show();
				});
				
				
			});
		};
	});
});
