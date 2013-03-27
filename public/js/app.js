$(document).ready(function() {
  $("form").submit(function(event){
    event.preventDefault();
    var tweet = $(this).serialize(); //get the text

  $.ajax({
    url: $(this).attr('action'), //get it from the form
    method: $(this).attr('method'), //get it from the form
    data: tweet
  })
  .done(function(response){
    alert(response);
  });





  });


});