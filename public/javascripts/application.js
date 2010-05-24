// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function() {
  $("div#flash_message, div#flash_notice, div#flash_warning, div#flash_error").delay(5000).fadeOut(1000, function() {
    // Animation complete.
  });
});
