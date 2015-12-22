$(document).on('page:change', function(){
  $('.share').click(function(evt){
    var link = $(this);
    window.open(link.attr('href'), 'popup', 'height=500,width=500');
    evt.preventDefault();
  })
})
