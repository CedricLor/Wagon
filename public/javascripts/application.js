function navBarHandle() {
  // if they click on then button, render the navbar
  $('.menu-btn-js-handle').click(function(event) {
    event.preventDefault();
    $('.side-nav').css("z-index",999);
    $('.side-nav-wrapper').addClass("side-nav-wrapper-open").removeClass('side-nav-wrapper-close');
    event.stopPropagation();
  });

  $('.side-nav').on('click', function() {
    remove_z_index = function() {
      $('.side-nav').css("z-index","");
    };
    if ($('.side-nav-wrapper').hasClass('side-nav-wrapper-open')) {
      $('.side-nav-wrapper').addClass('side-nav-wrapper-close').removeClass("side-nav-wrapper-open");
      setTimeout(remove_z_index, 240);
    }
  });
};

$(document).ready(function() {
  navBarHandle();
});
