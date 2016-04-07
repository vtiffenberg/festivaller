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
//= require jquery.turbolinks
//= require jquery_ujs
//= require materialize-sprockets
//= require turbolinks
//= require vue
//= require_tree .

jQuery(document).ready(function($) {

  $(".clickable-row").click(function() {
      window.document.location = $(this).data("href");
  });

  $('select.colorpicker-shortlist').simplecolorpicker();

  $('.datepicker').pickadate({
    selectMonths: true // Creates a dropdown to control month
  });

  $(document).ready(function() {
    $('select.material').material_select();
  });

  $('.timepicker').pickatime({
    twelvehour: true,
    donetext: 'Done',
    beforeShow: function() {
      activeElement = $(document.activeElement);
      activeForm = activeElement.closest('form')[0];
    },
    afterDone: function() {
      activeElement = $(document.activeElement);
      $(activeElement).enableClientSideValidations();
    }
  });

});
