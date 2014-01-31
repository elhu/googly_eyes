$(document).ready(function() {

  $.getJSON("/styles", function(styles) {
    styles.forEach(function(style) {
      var opt = "<option name=" + style + ">" + style + "</option>";
      $('select[name="style"]').append(opt);
    });
  });

});
