$(document).ready ->
  lang = $('html').attr('lang');
  console.log(lang);
  console.log($("input[type='datetime-local']"));
  $("input[type='datetime-local']").fdatetimepicker({
    language: lang
  });
