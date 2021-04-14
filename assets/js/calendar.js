$(window).on('load', function(){
  $('.progress-submission').each(function(i) {
    update_progress($(this));
  });
});

function date_ratio(base, target){
  var milliseconds = target.getTime() - base.getTime();
  var days = Math.ceil(milliseconds / (1000 * 3600 * 24));

  if (days <= 0)
    return 0;
  else if (days >= 365)
    return 100;
  else
    return Math.ceil(100 * days / 365);
}

function update_progress(elem) {
  var base = new Date(elem.children('.overlay').attr("base"));

  var one_year_before = new Date(
    base.getFullYear() - 1, base.getMonth(), base.getDate());

  var ratio = date_ratio(one_year_before, new Date());

  elem.children('.overlay').css('width', ratio + '%');
  elem.children('.overlay').attr('aria-valuenow', ratio)
}
