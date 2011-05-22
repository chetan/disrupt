
$(window).load(function() {

  // $("#place").focus(function() {
  //     this.select();
  // });

  $("#dish").typeWatch({ wait: 300, highlight: true, captureLength: 2, callback: dishSearch });

  $("#dishes").change(function() {
    $("#dish").val( $("#dishes option:selected").text() );
  });

  $("#dish").focus();

  $("#place").typeWatch({ wait: 300, highlight: true, captureLength: 2, callback: placeSearch });

  $("#places").change(function() {
    $("#place").val( $("#places option:selected").text() );
  });

});

function dishSearch() {

	var url = '/dishes/search.json?q=' + $("#dish").val();
  $.getJSON(url, function(data) {

    var opts = "";
    for (var i = 0; i < data.length; i++) {
      var dish = data[i].dish;
      opts += '<option value="' + dish.id + '">' + dish.name + '</option>';
    }

    $("#dishes")[0].options.length = 0;
    $("#dishes").append(opts);
    $("#dishes").selectmenu('refresh', true);
    $("#dishes").selectmenu('open');

  });

}


function placeSearch() {

	var url = '/places/search.json?q=' + $("#place").val();
  $.getJSON(url, function(data) {

    var opts = "";
    for (var i = 0; i < data.length; i++) {
      var venue = data[i].venue;
      opts += '<option value="' + venue.id + '">' + venue.name + '</option>';
    }

    $("#places")[0].options.length = 0;
    $("#places").append(opts);
    $("#places").selectmenu('refresh', true);
    $("#places").selectmenu('open');

  });

}
