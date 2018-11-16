$(window).on('load', function(){
  $('.jsdateupdate').each(function(i) {
    updatedate($(this));
  });
});

function updatedate(elem){
  var conference = new Date(elem.attr("conference"));
  var base = new Date(conference.getFullYear()-1, conference.getMonth(), conference.getDate());

  var diff = date_diff(base, new Date());
  elem.children('.darken').css('width',diff + '%');

  var deadline = elem.attr("deadline");
  if (deadline) {
    var diff = date_diff(base, new Date(deadline));
    elem.children('.colored').css('width', diff + '%');
    elem.children('.dealine').css('width', diff + '%');
  }
}

function date_diff(base, target){
  var diff = Math.ceil((target.getTime() - base.getTime())/(1000 * 3600 * 24));
  if (diff <= 0) return 0;
  else if (diff >= 365) return 100;
  else return Math.ceil(100 * diff / 365);
}
