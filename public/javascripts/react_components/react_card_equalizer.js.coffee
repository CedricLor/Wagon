DOM = React.DOM

rawMarkup= (raw) ->
  { __html: raw }

########################################
## ClearFixSm Component
########################################
ClearFixSm = React.createClass
  displayName: "Card"

  render: ->
    DOM.div
      className: "clearfix visible-sm"
      dangerouslySetInnerHTML: rawMarkup("&nbsp;")

########################################
## ClearFixLg Component
########################################
ClearFixLg = React.createClass
  displayName: "Card"

  render: ->
    DOM.div
      className: "clearfix hidden-sm hidden-xs"
      dangerouslySetInnerHTML: rawMarkup("&nbsp;")

########################################
## Image Component
########################################
Image = React.createClass
  displayName: "Image"

  render: ->
    DOM.img
      src: @props.cardImageSource
      alt: @props.newsTitle

########################################
## Card Component
########################################
Card = React.createClass
  displayName: "Card"

  componentDidMount: ->
    height = @refs[@props.cardNumber].clientHeight
    @props.myHeightIs(height, @props.id, @props.rowIndexInRowOfTwo, @props.rowIndexInRowOfThree)

  equalizerSwitcher: ->
    if $(window).width() >= 992 then @equalizeByThree() else if $(window).width() >= 768 then @equalizeByTwo()

  rawMarkup: (raw) ->
    { __html: raw }

  render: ->
    DOM.div
      className: "news-listing col-sm-6 col-md-4"
      DOM.div
        className: "thumbnail outer-wrapper-news-div"
        style:
          minHeight: "0px"
        DOM.div
          className: "inner-wrapper-news-div"
          ref: @props.cardNumber
          style:
            minHeight: @props.minHeight
          React.createElement Image,
            cardImageSource: @props.cardImageSource
            newsTitle: @props.newsTitle
          DOM.div
            className: "legend"
            DOM.h3 null, @props.newsTitle
            DOM.div
              className: "teaser"
              dangerouslySetInnerHTML: @rawMarkup(@props.newsTeaser)
          DOM.p
            className: "btn-container"
            DOM.a
              href: @props.cardBtnTarget
              className: "btn btn-primary"
              @props.localizedReadMore

########################################
## CardContainer Component
########################################
CardContainer = React.createClass
  displayName: "CardContainer"

  arrayBuilder: (chunk_size) ->
    empty_div_height_array = []
    j = 1
    for card, i in @props.domElements by chunk_size
      empty_div_height_array[ j ] = 0
      j++

  getInitialState: ->
    heightOfRowsOfTwo: @arrayBuilder(2)
    heightOfRowsOfThree: @arrayBuilder(3)

  howHighAreYou: (height, index, row_index_by_two, row_index_by_three) ->
    @setHeightOfRowByTwo(height, index, row_index_by_two)
    # @setHeightOfRowByThree(height, index, row_index_by_three)

  setHeightOfRowByTwo: (height, index, row_index_by_two) ->
    heightOfRowsOfTwo = @state.heightOfRowsOfTwo
    console.log("in set height")
    console.log(height > heightOfRowsOfTwo[row_index_by_two])
    heightOfRowsOfTwo[row_index_by_two] = height if height > @state.heightOfRowsOfTwo[row_index_by_two]
    @setState heightOfRowsOfTwo : heightOfRowsOfTwo

  # setHeightOfRowByThree: (height, index, row_index_by_three) ->
  #   heightOfRowsOfThree = @state.heightOfRowsOfThree
  #   heightOfRowsOfThree[row_index_by_three] = height if height > @state.heightOfRowsOfThree[row_index_by_three]
  #   @setState heightOfRowsOfThree : heightOfRowsOfThree[row_index_by_three]

  passToEqualizer: (naturalHeight_of_card_number) ->
    maxHeight = 0;
    items.each ->
      if $(this).height() > maxHeight
        maxHeight = $(this).height()
      return

  createClearFix: (i) ->
    if i %% 2 == 0
      clearFixSm = React.createElement ClearFixSm,
        key: "clear-fix-sm-#{i}"
    if i %% 3 == 0
      clearFixLg = React.createElement ClearFixLg,
        key: "clear-fix-lg-#{i}"
    [clearFixSm, clearFixLg]

  createCards: ->
    indexRowOfTwo = 1
    indexRowOfThree = 1
    for card, i in @props.domElements
      element = React.createElement Card,
        id: i + 1
        key: i + 1
        cardImageSource: card.dataset.imageSrc
        newsTitle: card.dataset.cardTitle
        newsTeaser: card.dataset.teaser
        localizedReadMore: card.dataset.readMore
        cardBtnTarget: card.dataset.btnTarget
        cardNumber: card.dataset.id
        rowIndexInRowOfTwo: indexRowOfTwo
        rowIndexInRowOfThree: indexRowOfThree
        myHeightIs: @howHighAreYou
        # minHeight: @state.heightForRow(@state.numberOfCardsInRow)
        # minHeightOfInnerWrapper: @state.heightForRow(@state.numberOfCardsInRow)
      clearfix = @createClearFix(i + 1, indexRowOfTwo, indexRowOfThree)
      if (i+1) %% 2 == 0 then indexRowOfTwo++
      if (i+1) %% 3 == 0 then indexRowOfThree++
      [element, clearfix]

  render: ->
    console.log(@state.heightOfRowsOfTwo)
    DOM.div
      className: "row"
      @createCards()

########################################
## ReactDOM.render function
########################################
create_card_with = (dom_element) ->
  # json_parsed_content = JSON.parse( source.dataset.imagesource )
  cardImageSource = dom_element.dataset.imageSrc
  newsTitle = dom_element.dataset.cardTitle
  newsTeaser = dom_element.dataset.teaser
  localizedReadMore = dom_element.dataset.readMore
  cardBtnTarget = dom_element.dataset.btnTarget
  cardNumber = dom_element.dataset.id
  ReactDOM.render(
    React.createElement Card,
      cardImageSource: cardImageSource
      newsTitle: newsTitle
      newsTeaser: newsTeaser
      localizedReadMore: localizedReadMore
      cardBtnTarget: cardBtnTarget
      cardNumber: cardNumber
    dom_element
  )

########################################
# Init and loop over various React tags
########################################
$ ->
  dom_elements = document.getElementsByClassName("react-card-box")
  target_dom_element = document.getElementById("react-box-container-target-element")
  created_card_container = React.createElement CardContainer,
    domElements: dom_elements
  ReactDOM.render(
    created_card_container
    target_dom_element
  )
