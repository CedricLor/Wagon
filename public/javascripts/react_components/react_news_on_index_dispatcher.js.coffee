
init_hero_news = ->
  react_target = document.getElementById("react-box-container-hero-news-target-element")
  localizedReadMore = react_target.dataset.readMore
  colClasses = react_target.dataset.colClass
  clearFixClassesForTwoCards = react_target.dataset.clearFixClassesForTwoCards
  clearFixClassesForThreeCards = react_target.dataset.clearFixClassesForThreeCards
  clearFixClassesForFourCards = react_target.dataset.clearFixClassesForFourCards
  source_dom_elements = document.getElementsByClassName("react-card-boxes-hero-news")
  console.log(source_dom_elements)

  r = new ReactCardEqualizer(
    react_target,
    localizedReadMore,
    colClasses,
    clearFixClassesForTwoCards,
    clearFixClassesForThreeCards,
    clearFixClassesForFourCards,
    source_dom_elements
    )

init_second_row_news = ->
  console.log("init_second_row")
  react_target = document.getElementById("react-box-container-older-news-target-element")
  localizedReadMore = react_target.dataset.readMore
  colClasses = react_target.dataset.colClass
  clearFixClassesForTwoCards = react_target.dataset.clearFixClassesForTwoCards
  clearFixClassesForThreeCards = react_target.dataset.clearFixClassesForThreeCards
  clearFixClassesForFourCards = react_target.dataset.clearFixClassesForFourCards
  source_dom_elements = document.getElementsByClassName("react-card-box-older-news")

  r = new ReactCardEqualizer(
    react_target,
    localizedReadMore,
    colClasses,
    clearFixClassesForTwoCards,
    clearFixClassesForThreeCards,
    clearFixClassesForFourCards,
    source_dom_elements
    )

$ ->
  init_hero_news() if $(".page-index").length != 0
  init_second_row_news() if $(".page-index").length != 0
