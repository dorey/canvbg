###
This is a proof of concept that allows you to set the background-image of elements
on the page to the image contents of a canvas prepared by javascript.

Works in FF14 and Chrome 21.0.1180...

Usage:
$.canvbg(selector, options, callback);

    selector:
      a valid css selector

    options:
      an object containing a width and a height

    callback:
      a function which draws the canvas

Example draws an "X" in the background of the body:

  $.canvbg('body', {
    width: 20,
    height: 20
  }, function(ctx){
    // first argument is a canvas' 2d context.
    ctx.strokeStyle = "#000";
    ctx.lineWidth = 1;
    ctx.beginPath();
    ctx.moveTo(1,1);
    ctx.lineTo(9,9);
    ctx.moveTo(9,1);
    ctx.lineTo(1,9);
    ctx.closePath();
    ctx.stroke();
  });

###

canvbgs = {}
style_elem = null

populate_style_elem = ()->
  ###
  ensures that this element is in the head:
    <style type='text/css' id='canvbg'>...</style>
  and then fills it with the different "background-image" styles.
  ###
  contents = []
  for selector, data of canvbgs
    contents.push "#{selector} { background-image:url(#{data}); }"
  style_elem ||= $('<style>', {type:'text/css', 'id': 'canvbg'}).appendTo('head')
  style_elem.html(contents.join(' '))

canvbg = (selector, opts, canvasCallback)->
  # creates a temporary <canvas>
  canvas = document.createElement('canvas')
  canvas.width = opts.width
  canvas.height = opts.height
  if canvas.getContext
    # runs the callback function with one argument, the 2d context.
    canvasCallback.call(canvas, canvas.getContext('2d'))

    # saves the resulting image as a string
    # (image is in format: "data:image/png;base64...")
    canvbgs[selector] = canvas.toDataURL()

    # rebuilds the <style> element each time
    populate_style_elem()
    true

jQuery.canvbg = canvbg
