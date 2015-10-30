/* Bootstrap autocompleter default configuration start */
$.fn.typeahead.defaults['source'] = function(text, process){
  var searchUrl = $(this.$element).attr("data-search");
  $.get(searchUrl, { search: text })
    .done( function(data){ return process(data) } );
}
/* Bootstrap autocompleter default configuration end */
jQuery(document).ready(function(){
  autocomplete('.typeahead');
});

/* Observe bootstrap autocompleter start */
function autocomplete(selector){
  $(selector).each(function(id, element){
    $(element).one('focus', function(event){
      $(this).typeahead({
        updater: function(data){
          var input = $(this.$element);
          var url = input.attr('data-submit');
          var type = input.attr('data-method') || 'POST';
          $.ajax({ type: type, url: url, data: data })
        }
      });
    });
  });
}
/* Observe bootstrap autocompleter end */
