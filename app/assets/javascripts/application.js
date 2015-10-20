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
//= require admin/articles.coffee

/* 
  workaround for default font 'Times New Roman', which fails in Chrome with:
  "Uncaught Error: Syntax error, unrecognized expression: [data-'Times New Roman'-abide]"
*/
//$(function(){ $(document).foundation(); });
/*
Foundation.set_namespace = function () {
  this.global.namespace = [];
};
$(document).foundation();
*/
