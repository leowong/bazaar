var add_image_handlers = function() {
  $('ul.thumbnails li').eq(0).addClass('selected');
  $('ul.thumbnails li a').click(function() {
    $('ul.thumbnails li').removeClass('selected');
    $(this).parent('li').addClass('selected');
    return false;
  });
};

$(document).ready(function() {
  $('.flash-messages').delay(5000).fadeOut(500);

  var toss_uri = '/toss'
  var badBrowser = (/MSIE ((5\.5)|6)/.test(navigator.userAgent) && navigator.platform == "Win32");

  if(badBrowser) {
    $('#toss').click(function(e) {
      $('#toss').fadeOut(200);
      $.get(toss_uri, function(data) {
        $('#product-listing').replaceWith($(data));
        $('#toss').delay(500).fadeIn(500);
      });
      e.preventDefault();
    });
  } else {
    $('#toss').click(function(e) {
      $('#toss').fadeOut(200);
      $.get(toss_uri, function(data) {
        $('#product-listing').quicksand($(data).find('li'), function() {
          $('#toss').delay(500).fadeIn(500);
        });
      });
      e.preventDefault();
    });
  }

  $('table.products tbody tr').hover(
    function() {
      $(this).addClass('hover');
    },
    function() {
      $(this).removeClass('hover');
    }
  );

  add_image_handlers();

  $("#q").focus();
});
