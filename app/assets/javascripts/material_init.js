jQuery(document).ready(function($) {

  $(".clickable-row").click(function() {
      window.document.location = $(this).data("href");
  });

  $('select.colorpicker-shortlist').simplecolorpicker();

  $('.datepicker').pickadate({
    selectMonths: true // Creates a dropdown to control month
  });

  $('select.material').material_select();

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

  $(".button-collapse").sideNav();

  setTimeout(function(){
    window.Materialize.updateTextFields();
  }, 0)

});
