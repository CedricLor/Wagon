
init_all_news = ->
  console.log("init_all_news")
  react_target = document.getElementById("react-box-container-target-element")
  localizedReadMore = react_target.dataset.readMore
  colClasses = react_target.dataset.colClass
  clearFixClassesForTwoCards = react_target.dataset.clearFixClassesForTwoCards
  clearFixClassesForThreeCards = react_target.dataset.clearFixClassesForThreeCards
  clearFixClassesForFourCards = react_target.dataset.clearFixClassesForFourCards
  source_dom_elements = document.getElementsByClassName("react-card-box")

  r = new ReactCardEqualizer react_target, localizedReadMore, colClasses, clearFixClassesForTwoCards, clearFixClassesForThreeCards, clearFixClassesForFourCards, personalizationClassesSlug, source_dom_elements

$ ->
  init_all_news if $(".page-news").length != 0
