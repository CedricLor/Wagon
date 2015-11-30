DOM = React.DOM

########################################
## ClearFixSm Component
########################################
ClearFixSm = React.createClass
  displayName: "Card"

  render: ->
    DOM.div
      className: "clearfix visible-sm"

########################################
## ClearFixLg Component
########################################
ClearFixSm = React.createClass
  displayName: "Card"

  render: ->
    DOM.div
      className: "clearfix hidden-sm hidden-xs"
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
    # console.log("hello")
    height = @refs[@props.cardNumber].offsetHeight
    console.log(@refs[@props.cardNumber].offsetHeight)
    @equalizerSwitcher()
    # console.log(@refs[@props.cardNumber].style.height)
    # @props.iGiveYouMyNaturalHeight(height)

  equalizeByThree: ->
    console.log("toto")

  equalizeByTwo: ->
    console.log("tata")

  equalizerSwitcher: ->
    if $(window).width() >= 992 then @equalizeByThree() else if $(window).width() >= 768 then @equalizeByTwo()

  rawMarkup: (raw) ->
    { __html: raw }

  render: ->
    DOM.div
      className: "thumbnail outer-wrapper-news-div"
      ref: @props.cardNumber
      style:
        minHeight: "0px"
      DOM.div
        className: "inner-wrapper-news-div"
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

  # if( $(window).width() >= 992 ) {
  #   for(var i = 0; i < news.length; i+=3) { equalizeHeights( news.slice(i, i+3) ); }
  # } else if ( $(window).width() >= 768 ) {
  #   for(var i = 0; i < news.length; i+=2) { equalizeHeights( news.slice(i, i+2) ); }
  # }


########################################
## CardContainer Component
########################################
# CardContainer = React.createClass
#   displayName: "CardContainer"

#   getInitialState: ->
#     heightsOfRowsOfTwo: {}
#     heightsOfRowsOfThree: {}

#   howHighAreYou: (height, index) ->
#     naturalHeight_of_card_number[index] = height
#     @passToEqualizer(naturalHeight_of_card_number)

#   passToEqualizer: (naturalHeight_of_card_number) ->
#     maxHeight = 0;
#     items.each ->
#       if $(this).height() > maxHeight
#         maxHeight = $(this).height()
#       return

#   createCards: ->
#     for card, i in @props.cards
#       React.createElement Card,
#         key: i + 1
#         imageSource: card.imageSource
#         imageAlt: card.imageAlt
#         teaser: card.teaser
#         newsHRef: card.newsHRef
#         readMoreMessage: card.readMoreMessage
#         rowIndexInRowOfTwo: card.indexInRowOfTwo
#         rowIndexInRowOfThree: card.indexInRowOfThree
#         minHeightOfInnerWrapper: @state.heightForRow(@state.numberOfCardsInRow)
#         iGiveYouMyNaturalHeight: @howHighAreYou()
#       React.createElement ClearFixSm if i %% 2 == 0
#       React.createElement ClearFixLg if i %% 3 == 0

#   render: ->
#     DOM.div
#       className: "row"
#       @createCards()

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
  create_card_with dom_element for dom_element in dom_elements
