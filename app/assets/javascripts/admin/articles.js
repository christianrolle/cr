$(document).ready(function(){
  $('input[type="datetime-local"]').on('click', function(){
    $(this).dattimepicker({
      format: 'DD.MM.YYYY, HH:mm',
      extraFormats: ['YYYY-MM-DD HH:mm']
    }); 
  })
})
