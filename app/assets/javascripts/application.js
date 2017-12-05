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
//= require bootstrap-sprockets
//= require moment
//= require bootstrap-datetimepicker
//= require_tree .
/* global $ */


var degrees = 90;

$( document ).ready(function() {
  if($(window).width() >=766) $('.pdf-link').attr("target", "_blank");
  else $('.pdf-link').removeAttr("target");
  
  
  $('.reports-table td label').on('click', function () {
    //$(this).rotate(90);
    $(this).children('.glyphicon').toggleClass('down');
  });
});


$( window ).resize(function() {
  if($(window).width() >=766) $('.pdf-link').attr("target", "_blank");
  else $('.pdf-link').removeAttr("target");
});

