function equalizeHeights(items) {
  var maxHeight = 0;
  console.log("Hello JQuery")
  items.each(function() {
    console.log($(this).height())
    if ($(this).height() > maxHeight) { maxHeight = $(this).height(); }
  });
  items.each(function() {
    $(this).children("div.inner-wrapper-news-div").each(function() {
      $(this).css('min-height', (maxHeight - 50) + 'px');
      if ($(this).children("img").length == 0) {
        $(this).find("h3").css('margin-top', 0 + 'px');
      }
    });
  });
}

function formatPostListings() {
  var news = $('body.page-news div.news div.thumbnail');
  news.each(function(){ $(this).css('min-height', "0px"); });
  if( $(window).width() >= 992 ) {
    for(var i = 0; i < news.length; i+=3) { equalizeHeights( news.slice(i, i+3) ); }
  } else if ( $(window).width() >= 768 ) {
    for(var i = 0; i < news.length; i+=2) { equalizeHeights( news.slice(i, i+2) ); }
  }
}

$(document).ready(function() {

  $(window).on('load', formatPostListings);
  $(window).on('resize', formatPostListings);

});
