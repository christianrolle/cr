// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require moment
//= require bootstrap-datetimepicker
//= require vendor/bootstrap3-typeahead.min.js
//= require components/typeahead.js
//= require admin/articles

/* Bootstrap datetimepicker default configuration start */                      
$.extend(true, $.fn.datetimepicker.defaults, {                                  
  useCurrent: false,                                                            
  showTodayButton: true,                                                        
  showClear: true                                                               
})                                                                              
/* Bootstrap datetimepicker default configuration end */                        
$(document).ready(function(){
  $('input[type=datetime-local]').datetimepicker({
    format: 'DD.MM.YYYY, HH:mm',                                                
    extraFormats: ['YYYY-MM-DD HH:mm:ss']
  }).next().on('click', function(){
    $(this).prev().data('DateTimePicker').show()
  })
})

