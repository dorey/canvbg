(function() {
  var canvbg, canvbgs, populate_style_elem, style_elem;

  canvbgs = {};

  style_elem = null;

  populate_style_elem = function() {
    /*
      ensures that this element is in the head:
        <style type='text/css' id='canvbg'>...</style>
      and then fills it with the different "background-image" styles.
    */

    var contents, data, selector;
    contents = [];
    for (selector in canvbgs) {
      data = canvbgs[selector];
      contents.push("" + selector + " { background-image:url(" + data + "); }");
    }
    style_elem || (style_elem = $('<style>', {
      type: 'text/css',
      'id': 'canvbg'
    }).appendTo('head'));
    return style_elem.html(contents.join(' '));
  };

  canvbg = function(selector, opts, canvasCallback) {
    var canvas;
    canvas = document.createElement('canvas');
    canvas.width = opts.width;
    canvas.height = opts.height;
    if (canvas.getContext) {
      canvasCallback.call(canvas, canvas.getContext('2d'));
      canvbgs[selector] = canvas.toDataURL();
      populate_style_elem();
      return true;
    }
  };

  jQuery.canvbg = canvbg;

}).call(this);