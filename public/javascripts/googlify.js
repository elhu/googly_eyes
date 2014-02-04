window.onpopstate = function(event) {
  processState();
};

function processState() {
  var params = getParameters();
  if (params.url !== undefined) {
    renderImage(params.url, params.style);
  }
}

function renderImage(imgUrl, style) {
  var container = $("div.result");
  var protocol = window.location.protocol;
  var opts = {
    protocol: protocol.substr(0, protocol.length - 1),
    host: window.location.host,
    path: '/googlify',
    params: {
      url: imgUrl,
      style: style
    }
  };
  var url = $.url.build(opts);
  opts.path = '/';
  var permalink = $.url.build(opts);
  container.find("input[name=permalink]").val(permalink);
  container.find("img").attr('src', url);
  container.removeClass('hidden');
}

function getParameters() {
  var searchString = window.location.search.substring(1),
      params = searchString.split("&"),
      hash = {};

  if (searchString == "") return {};
  for (var i = 0; i < params.length; i++) {
    var val = params[i].split("=");
    hash[unescape(val[0])] = unescape(val[1]);
  }
  return hash;
}

$(document).ready(function() {
  processState();
  $.getJSON("/styles", function(styles) {
    styles.forEach(function(style) {
      var opt = "<option name=" + style + ">" + style + "</option>";
      $('select[name="style"]').append(opt);
    });
  });

  $('form#googlify').submit(function(event) {
    event.preventDefault();
    var url = $(event.target).find("input[name=url]")[0].value;
    var style = $(event.target).find("select[name=style]")[0].value;
    var spinContainer = $("div.spinner-container");
    $("div.result").addClass('hidden');
    spinContainer.spin();
    $.ajax({
      type: 'HEAD',
      url: event.target.action,
      data: {
        url: url,
        style: style
      },
      success: function(data, status, xhr) {
        history.pushState({}, 'googlify', $.url.build({ params: { url: url, style: style } }));
        spinContainer.spin(false);
        renderImage(url, style);
      },
      error: function(data, status, xhr) {
        alert("Could not add googly eyes on " + $(event.target).find("input[name=url]")[0].value);
      }
    });
  });
});
