$(document).ready(function() {
  $('.flash-messages').delay(5000).fadeOut(500);

  var badBrowser = (/MSIE ((5\.5)|6)/.test(navigator.userAgent) && navigator.platform == "Win32");

  if(badBrowser) {
    $('#toss').click(function(e) {
      $('#toss').fadeOut(200);
      $.get($(this).attr('href'), function(data) {
        $('#product-listing').replaceWith($(data));
        $('#toss').delay(500).fadeIn(500);
      });
      e.preventDefault();
    });
  } else {
    $('#toss').click(function(e) {
      $('#toss').fadeOut(200);
      /* $('.image-shadow').css('background', 'none !important'); */
      $.get($(this).attr('href'), function(data) {
        $('#product-listing').quicksand($(data).find('li'), function() {
	  /* $('li div.image').addClass('image-shadow'); */
          $('#toss').delay(500).fadeIn(500);
        });
      });
      e.preventDefault();
    });
  }
});
