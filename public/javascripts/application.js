$(document).ready(function(){
  $(':date').dateinput({format: 'yyyy-mm-dd'});
  $('#add_request').click(function(e){
    $('.form').show();
    $('#cancel_request').show();
    $(this).hide();
  });
  $('#cancel_request').click(function(e){
    $('.form').hide();
    $(this).hide();
    $('#add_request').show();
  });
  
  $('a.get_place').click(function(e){
    e.preventDefault();
    if (confirm('Точно поедете?')) {
      $.ajax({
        url: this.href, 
        type: 'PUT', 
        success: function(){
          alert(1);
        }
      });
    }
  });
});
