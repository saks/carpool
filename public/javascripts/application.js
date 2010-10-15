$(document).ready(function(){
  $(':date').dateinput({format: 'yyyy-mm-dd'});
  $('#add_request').click(function(e){
    e.preventDefault();
    $('.form').show();
    $('#cancel_request').show();
    $(this).hide();
  });
  $('#cancel_request').click(function(e){
    e.preventDefault();
    $('.form').hide();
    $(this).hide();
    $('#add_request').show();
  });
  
  $('a.get_place').click(function(e){
    e.preventDefault();
    if (confirm('Точно поедете?')) {
      var tr = $(this).parents('tr');
      var link = $(this);
      $.ajax({
        url: this.href,
        type: 'PUT',
        success: function(str){
          tr.find('span.empty_count').text(str);
          if (str == '0') {
            tr.addClass('disabled');
            link.hide();
          }
        }
      });
    }
  });
});