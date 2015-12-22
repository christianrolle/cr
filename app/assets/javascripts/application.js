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
//= require moment/de.js
//= require moment/en-gb.js
//= require bootstrap-sprockets
//= require bootstrap-datetimepicker
//= require vendor/bootstrap3-typeahead.min.js
//= require components/typeahead.js
//= require components/modal.js
//= require components/analytics.js
//= require components/social_share.js
//= require admin/articles.js

/* Bootstrap datetimepicker default configuration start */                      
$.extend(true, $.fn.datetimepicker.defaults, {                                  
  useCurrent: false,                                                            
  showTodayButton: true,                                                        
  showClear: true                                                               
})                                                                              

moment.locale('en', {
  longDateFormat : {
    L : "YYYY-MM-DD",
    LT : "HH:mm",
  }
})

/* Bootstrap datetimepicker default configuration end */                        
$(document).on('page:change', function(){
  moment.locale( $('html').attr('lang') );

  $('input[type=datetime-local]').datetimepicker({
    format: "L, LT",
    extraFormats: ['YYYY-MM-DD HH:mm:ss'],
    locale: moment.locale()
  }).next().on('click', function(){
    $(this).prev().data('DateTimePicker').show()
  })
})

