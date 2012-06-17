$(document).ready(function(){
  var prettify = false;
  $("pre code").parent().each(function() {
    $(this).addClass('prettyprint');
    prettify = true;
  });

  if ( prettify ) {
    $.getScript("/javascripts/prettify.js", function() { prettyPrint() });
  }
});

