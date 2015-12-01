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
            minHeight: @props.minHeightOfInnerWrapper
          if @props.cardImageSource != ""
            React.createElement Image,
              cardImageSource: @props.cardImageSource
              newsTitle: @props.newsTitle
          DOM.div
            className: "legend"
            DOM.h3
              style:
                marginTop: 0 if @props.cardImageSource == ""
              @props.newsTitle
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
    for i in [1..@props.domElements.length] by chunk_size
      empty_div_height_array.push(0)
    empty_div_height_array

  numberOfCardsByRow: ->
    if window.innerWidth >= 992 then 3 else if window.innerWidth >= 768 then 2

  getInitialState: ->
    cardByRows: @numberOfCardsByRow()
    heightOfRowsByChunksOf:
      2: @arrayBuilder(2)
      3: @arrayBuilder(3)

  handleResize: ->
    @setState cardByRows: @numberOfCardsByRow()

  componentDidMount: ->
    window.addEventListener('resize', @handleResize)

  componentWillUnmount: ->
    window.removeEventListener('resize', @handleResize);

  inWhichRowIsTheCardByRowOf: (number_of_cards_by_row, index) ->
    index = index + 1
    if index % number_of_cards_by_row == 0 then index / number_of_cards_by_row else Math.ceil(index / number_of_cards_by_row)

  setRequiredHeightsOfRowsForThisCard: (heightOfRowsByChunksOf, i, height, card_index) ->
    row_index = @inWhichRowIsTheCardByRowOf(i, card_index)
    heightOfRowsByChunksOf[i][row_index] = height if height > heightOfRowsByChunksOf[i][row_index]

  setRequiredHeightsOfRows: (height, card_index) ->
    heightOfRowsByChunksOf = @state.heightOfRowsByChunksOf
    for i in [2..3]
      @setRequiredHeightsOfRowsForThisCard(heightOfRowsByChunksOf, i, height, card_index)
    @setState heightOfRowsByChunksOf : heightOfRowsByChunksOf

  createClearFix: (i) ->
    if i %% 2 == 0
      clearFixSm = React.createElement ClearFixSm,
        key: "clear-fix-sm-#{i}"
    if i %% 3 == 0
      clearFixLg = React.createElement ClearFixLg,
        key: "clear-fix-lg-#{i}"
    [clearFixSm, clearFixLg]

  createCards: ->
    for card, i in @props.domElements
      element = React.createElement Card,
        id: i
        key: i
        cardImageSource: card.dataset.imageSrc
        newsTitle: card.dataset.cardTitle
        newsTeaser: card.dataset.teaser
        localizedReadMore: card.dataset.readMore
        cardBtnTarget: card.dataset.btnTarget
        cardNumber: card.dataset.id
        myHeightIs: @setRequiredHeightsOfRows
        minHeightOfInnerWrapper: @state.heightOfRowsByChunksOf[@state.cardByRows][@inWhichRowIsTheCardByRowOf(@state.cardByRows, i)]
      clearfix = @createClearFix(i + 1)
      [element, clearfix]

  render: ->
    DOM.div
      className: "row"
      @createCards()

########################################
# Init and ReactDOM.render function
########################################
$ ->
  ReactDOM.render(
    React.createElement CardContainer,
      domElements: document.getElementsByClassName("react-card-box")
    document.getElementById("react-box-container-target-element")
  )
