$(document).on('page:change', function(){
  $('#articles .tag.search').one('focus', function(evt){
    console.log('Focused')
    $(this).typeahead({
      source: function(text, process){
    console.log('typeahead')
        var tag_ids = []
        $('.tags input').each(function(){
          tag_ids.push($(this).val())
        })
        var searchUrl = $(this.$element).attr("data-search");
    console.log(searchUrl)
        $.get(searchUrl, { search: text, "tag_ids[]": tag_ids })
            .done( function(data){ return process(data) } );
      },
      updater: function(data){
        var elementId = 'tag_' + data['id']
        var html = $("<input type='checkbox' checked='checked' class='hidden' name='article[tag_ids][]' id=" + elementId + " value=" + data['id'] + "><label for=" + elementId + ">" + data['name'] + "</label>")
        $('#articles .tags').append(html)
        return '';
      }
    })
  })
});
