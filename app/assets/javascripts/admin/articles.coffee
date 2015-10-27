$(document).on 'click', 'input[type="datetime-local"]', ->
  $(this).dattimepicker({
    format: 'DD.MM.YYYY, HH:mm',
    extraFormats: ['YYYY-MM-DD HH:mm']
  });
