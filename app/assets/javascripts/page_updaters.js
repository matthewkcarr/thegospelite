function send_email_for_tracks(btn) {
	var message = $('#five_form').serializeArray();
	$.post($('#five_form').attr('action'), message, function(data){ 
		$('head').append(data);
	});
}

function shbam() {
	//console.log('shbam called');
	$('#shbam_container').html('');
	$('#shbam_container').append( $('#preload').html() );
	$.getJSON('/unlock/fan_shbam', function(data) {
		for (var i=0; i < data.length; i++) {
			if(data[i] != null) {
				var hash = data[i] ;
				//console.log(hash);
				var subhash = hash;
				$('#location_' + i).html( subhash.city + ", " + subhash.state);
				//console.log( subhash.city + ", " + subhash.state);
				$('#stats_' + i).html( "(x" + subhash.occurences + ")");
				//console.log( "(x" + subhash.occurences + ")");
			}
		}
		update_newest(); 
	});
}
	
function update_newest() {
	$.getJSON('/unlock/new_fan_shbam', function(ndata) {
		//console.log('length is ' + ndata.length);
		for (var j=0; j < ndata.length; j++) {
			if(ndata[j] != null) {
				var nhash = ndata[j] ;
				var nsubhash = nhash;
				//console.log(nsubhash);
				$('#nlocation_' + j).html( nsubhash.city + ", " + nsubhash.state);
				//console.log( nsubhash.city + ", " + nsubhash.state);
				$('#nstats_' + j).html( "(x" + nsubhash.occurences + ") - " + nsubhash.updated);
				//console.log( "(x" + nsubhash.occurences + ") - " + nsubhash.updated);
			}
		}
		//$('#location_hits').animate({backgroundColor: '#FFFFFF'})
		//$('#location_hits').animate({backgroundColor: '#000000'})
	});
}
	/*$.ajax( {
				 url: '/unlock/fivemore', 
				 complete: function(data) { 
										$('head').append(data);
									}
				});
				*/
function update_counts() {
	$.getJSON('/home/counts', function(data) {
		for (var key in data) {
			if (data.hasOwnProperty(key)) {
				if(data[key] != null) {
					var id = '#' + key + '_d';
					cont = $(id).html();
					if(cont != data[key]) { 
						$(id).animate({ color: "#76EE00" }, 1000);
						$(id).html(data[key]);
						$(id).animate({ color: "#000000" }, 1000);
					}
				}
			}
		}
	});
}
/* used to have onlcick handler that would do this routine */
/* but now the link does it */
function track_download(obj) {
		//var t_id = id.split('_');
		var t_id = $(obj).attr('id').split('_');
		$.getJSON('/home/downloaded/' + t_id[0], function(data) {
			id = '#' + t_id[0] + "_d"
			$(id).animate({color: '#76EE00'})
			$(id).html(data.downloads);
			$(id).animate({color: '#FFFFFF'})
		});
}
function do_message(btn) {
	var message = $('#message_us_form').serializeArray();
	$.post($('#message_us_form').attr('action'), message, function(data){ 
		var msg = '<div style="padding-top: 25px;">' + data + '</div>';
		$('#message_us_inputs').html(msg);
		$('#message_us_header').hide();
		$('.msgbox').center();
		$("#message_us_fuzz").fadeOut(3000);  
	});
	return false;
}
function do_notify(btn) {
	var message = $('#notified_form').serializeArray();
	$.post($('#notified_form').attr('action'), message, function(data){ 
		var msg = '<div style="padding-top: 25px;">' + data + '</div>';
		$('#notified_inputs').html(msg);
		$('#notified_header').hide();
		$('#notified_cont').center();
		$("#notified_fuzz").fadeOut(3000);  
	});
	return false;
}


$(document).ready(function(){ 

	$('#sbam_btn').click(function() {
		shbam();
	});

	$("#about_us_link").click(function(){  
		$("#about_us_fuzz").css("height", $(document).height()); 
		$("#about_us_fuzz").fadeIn();  
		$('#about_us_cont').center();
		return false;  
	});
	$("#notified_link").click(function(){  
		$("#notified_fuzz").css("height", $(document).height()); 
		$("#notified_fuzz").fadeIn();  
		$('#notified_cont').center();
		return false;  
	});
	/******************/
	/* for contact us */
	$("#message_us_link").click(function(){  
		$("#message_us_fuzz").css("height", $(document).height()); 
		$("#message_us_fuzz").fadeIn();  
		$('#message_us_cont').center();
		return false;  
	});  
	$("#five_close").click(function(){  
		$("#five_fuzz").fadeOut();  
		return false;  
	}); 
	$("#notified_close").click(function(){  
		$("#notified_fuzz").fadeOut();  
		return false;  
	}); 
	$("#message_us_close").click(function(){  
		$("#message_us_fuzz").fadeOut();  
		return false;  
	}); 
	$("#about_us_close").click(function(){  
		$("#about_us_fuzz").fadeOut();  
		return false;  
	}); 
	$(window).resize(function() {
		$('#message_us_cont').center();
		$('#notified_cont').center();
		$('#about_us_cont').center();
	});
	$(window).scroll(function() {
		$('#message_us_cont').center();
		$('#notified_cont').center();
		$('#about_us_cont').center();
	});

	/*$('.full').click( function(event) { 
		$.getJSON('/home/downloaded/' + event.target.id, function(data) {
			update_counts();
		});
	}); */
	/* for contact us */
	/******************/

	//if we use the stats partial then we need this. but not right now
	//var timer = setInterval("update_counts()",30000);
});
//audiojs.events.ready(function() {
//	var as = audiojs.createAll();
//});

$(function() {
	// Setup the player to autoplay the next track
	var a = audiojs.createAll({
		trackEnded: function() {
		var next = $('ol li.playing').next();
		if (!next.length) next = $('ol li').first();
			next.addClass('playing').siblings().removeClass('playing');
			audio.load($('a', next).attr('data-src'));
			audio.play();
		}
	});
	// Load in the first track
	var audio = a[0];
	first = $('ol a').attr('data-src');
	$('ol li').first().addClass('playing');
	audio.load(first);
	// Load in a track on click
	$('ol li').click(function(e) {
		e.preventDefault();
		$(this).addClass('playing').siblings().removeClass('playing');
		audio.load($('a', this).attr('data-src'));
		audio.play();
	});
	// Keyboard shortcuts
	$(document).keydown(function(e) {
		var unicode = e.charCode ? e.charCode : e.keyCode;
		// right arrow
		if (unicode == 39) {
			var next = $('li.playing').next();
			if (!next.length) next = $('ol li').first();
			next.click();
		// back arrow
		} else if (unicode == 37) {
			var prev = $('li.playing').prev();
			if (!prev.length) prev = $('ol li').last();
			prev.click();
		// spacebar
		} else if (unicode == 32) {
				audio.playPause();
		}
	})
}); 
