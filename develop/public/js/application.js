// Some general UI pack related JS
// Extend JS String with repeat method
String.prototype.repeat = function(num) {
    return new Array(num + 1).join(this);
};

(function($) {

  // Add segments to a slider
  $.fn.addSliderSegments = function (amount) {
    return this.each(function () {
      var segmentGap = 100 / (amount - 1) + "%"
        , segment = "<div class='ui-slider-segment' style='margin-left: " + segmentGap + ";'></div>";
      $(this).prepend(segment.repeat(amount - 2));
    });
  };

  $(function() {

    // Custom Selects
    $("select[name='hugexx']").selectpicker({style: 'btn-huge btn-primary', menuStyle: 'dropdown-inverse'});
    $("select[name='large']").selectpicker({style: 'btn-large btn-danger'});
    $("select[name='info']").selectpicker({style: 'btn-info'});
    $("select[name='small']").selectpicker({style: 'btn-small btn-warning'});

    // Tabs
    $(".nav-tabs a").on('click', function (e) {
      e.preventDefault();
      $(this).tab("show");
    })

    // Tooltips
    $("[data-toggle=tooltip]").tooltip("show");

    // Tags Input
    $(".tagsinput").tagsInput();

    // jQuery UI Sliders
    var $slider = $("#slider");
    $slider.slider({
      min: 1,
      max: 5,
      value: 3,
      orientation: "horizontal",
      range: "min"
    }).addSliderSegments($slider.slider("option").max);

    var $slider2 = $("#slider2");
    $slider2.slider({
      min: 1,
      max: 5,
      values: [3, 4],
      orientation: "horizontal",
      range: true
    }).addSliderSegments($slider2.slider("option").max);

    // jQuery UI Spinner
    $.widget( "ui.customspinner", $.ui.spinner, {
      _buttonHtml: function() { // Remove arrows on the buttons
        return "" +
  			"<a class='ui-spinner-button ui-spinner-up ui-corner-tr'>" +
  				"<span class='ui-icon " + this.options.icons.up + "'></span>" +
  			"</a>" +
  			"<a class='ui-spinner-button ui-spinner-down ui-corner-br'>" +
  				"<span class='ui-icon " + this.options.icons.down + "'></span>" +
  			"</a>";
      }
    });
    
    $('#spinner-01').customspinner({
      min: -99,
      max: 99
    }).on('focus', function () {
      $(this).closest('.ui-spinner').addClass('focus');
    }).on('blur', function () {
      $(this).closest('.ui-spinner').removeClass('focus');
    });


    // Focus state for append/prepend inputs
    $('.input-prepend, .input-append').on('focus', 'input', function () {
      $(this).closest('.control-group, form').addClass('focus');
    }).on('blur', 'input', function () {
      $(this).closest('.control-group, form').removeClass('focus');
    });

    // Table: Toggle all checkboxes
    $('.table .toggle-all').on('click', function() {
      var ch = $(this).find(':checkbox').prop('checked');
      $(this).closest('.table').find('tbody :checkbox').checkbox(!ch ? 'check' : 'uncheck');
    });

    // Table: Add class row selected
    $('.table tbody :checkbox').on('check uncheck toggle', function (e) {
      var $this = $(this)
        , check = $this.prop('checked')
        , toggle = e.type == 'toggle'
        , checkboxes = $('.table tbody :checkbox')
        , checkAll = checkboxes.length == checkboxes.filter(':checked').length
        
      $this.closest('tr')[check ? 'addClass' : 'removeClass']('selected-row');
      if (toggle) $this.closest('.table').find('.toggle-all :checkbox').checkbox(checkAll ? 'check' : 'uncheck');
    });

    // jQuery UI Datepicker
    $('#datepicker-01').datepicker({
      showOtherMonths: true,
      selectOtherMonths: true,
      dateFormat: "d MM, yy",
      yearRange: '-1:+1'
    }).prev('.btn').on('click', function (e) {
      e && e.preventDefault();
      $('#datepicker-01').focus();
    });
    $.extend($.datepicker, {_checkOffset:function(inst,offset,isFixed){return offset}});

    // Custom checkboxes
    $('[data-toggle="checkbox"]').checkbox();

    // Custom radios
    $('[data-toggle="radio"]').radio();

    // Switch
    $("[data-toggle='switch']").wrap('<div class="switch" />').parent().bootstrapSwitch();

    // Stackable tables
    $(".table-striped").stacktable({id: "rwd-table"});
  });
})(jQuery);
