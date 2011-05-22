
$(window).load(function() {

  FB.init({
    appId  : '166257770103222',
    status : true, // check login status
    cookie : true, // enable cookies to allow the server to access the session
    xfbml  : true  // parse XFBML
  });

  FB.login();

  if (geo_position_js.init()) {
      geo_position_js.getCurrentPosition(success_callback,error_callback,{enableHighAccuracy:true,options:5000});
  }

  function success_callback(p) {
    $.ajax("/geo/set?lat=" + p.coords.latitude + "&lng=" + p.coords.longitude);
  }

  function error_callback(p) {
  }

  // $("#place").focus(function() {
  //     this.select();
  // });

  $("#dish").typeWatch({ wait: 300, highlight: true, captureLength: 2, callback: dishSearch });

  $("#dishes").change(function() {
    var sel = $("#dishes option:selected");
    $("#dish").val( sel.text() );
    $("#dish_id").val( sel.val() );
    // pull current rankings for this dish
    $.getJSON("/rankings/search?dish_id=" + sel.val(), function(data) {
      if (data.length == 0) {
        $("div.current_rankings").hide();
        return;
      }
      $("div.current_rankings").show();
      var items = "<ol>";
      for (var i = 0; i < data.length; i++) {
        var rank = data[i].ranking;
        items += '<li>' + rank.venue.name + '</option>';
      }
      items += "</ol>";
      $("div.current_rankings span").html(items);
    });
  });

  $("#dish").focus();


  $("#place").typeWatch({ wait: 300, highlight: true, captureLength: 2, callback: placeSearch });

  $("#places").change(function() {
    var sel = $("#places option:selected");
    $("#place").val( sel.text() );
    $("#place_id").val( sel.val() );
  });


  $("input.ranking").change(function() {
    var val = $(this).val();
    if (val > 10) {
      val = "10+";
    }
    $("span.ranking strong").html( val );
  });


  $("a.save_ranking").click(function() {
    $("form").submit();
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
