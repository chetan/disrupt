
$(window).load(function() {

  // $("#place").focus(function() {
  //     this.select();
  // });

  $("#place").typeWatch({ wait: 300, highlight: true, captureLength: 2, callback: placeSearch });

  $("#places").change(function() {
    console.log("selected something...")
    $("#place").val( $("#places option:selected").text() );
  });

  $("#place").focus();

});

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
