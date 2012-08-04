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