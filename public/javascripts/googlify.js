function renderImage(url) {
  var container = $("div.result");
  container.find("input[name=permalink]").val(url);
  container.find("img").attr('src', url);
  container.removeClass('hidden');
}

$(document).ready(function() {
  $.getJSON("/styles", function(styles) {
    styles.forEach(function(style) {
      var opt = "<option name=" + style + ">" + style + "</option>";
      $('select[name="style"]').append(opt);
    });
  });

  $('form#googlify').submit(function(event) {
    event.preventDefault();
    $.ajax({
      type: 'HEAD',
      url: event.target.action,
      data: {
        url: $(event.target).find("input[name=url]")[0].value,
        style: $(event.target).find("select[name=style]")[0].value
      },
      success: function(data, status, xhr) {
        renderImage(this.url);
      },
      error: function(data, status, xhr) {
        alert("Could not add googly eyes on " + $(event.target).find("input[name=url]")[0].value);
      }
    });
  });
});
