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
## Card Component
########################################
Card = React.createClass
  displayName: "Card"

  onComponentDidMount: ->
    height = @refs["card-{@props.key}"].style.height
    @props.iGiveYouMyNaturalHeight(height)

  render: ->
    DOM.div
      className: "news-listing col-sm-6 col-md-4"
      DOM.div
        className: "thumbnail outer-wrapper-news-div"
        DOM.div
          className: "inner-wrapper-news-div"
          DOM.img
            src: @props.imageSource
            alt: @props.imageAlt
            ref: "card-{@props.key}"
          DOM.div
            class: "legend"
            DOM.h3
              null,
              DOM.div
                className: "teaser"
                DOM.p
                  null,
                  "#{@props.teaser}"
          DOM.p
            className: "btn-container"
            DOM.a
              href: @props.newsHRef
              className: "btn btn-primary"
              "{@props.read_more_message}"


########################################
## CardContainer Component
########################################
CardContainer = React.createClass
  displayName: "CardContainer"

  getInitialState: ->
    heightsOfRowsOfTwo: {}
    heightsOfRowsOfThree: {}

  howHighAreYou: (height, index) ->
    naturalHeight_of_card_number[index] = height
    @passToEqualizer(naturalHeight_of_card_number)

  passToEqualizer: (naturalHeight_of_card_number) ->
    maxHeight = 0;
    items.each ->
      if $(this).height() > maxHeight
        maxHeight = $(this).height()
      return


  createCards: ->
    for card, i in @props.cards
      React.createElement Card,
        key: i + 1
        imageSource: card.imageSource
        imageAlt: card.imageAlt
        teaser: card.teaser
        newsHRef: card.newsHRef
        readMoreMessage: card.readMoreMessage
        rowIndexInRowOfTwo: card.indexInRowOfTwo
        rowIndexInRowOfThree: card.indexInRowOfThree
        minHeightOfInnerWrapper: @state.heightForRow(@state.numberOfCardsInRow)
        iGiveYouMyNaturalHeight: @howHighAreYou()
      React.createElement ClearFixSm if i %% 2 == 0
      React.createElement ClearFixLg if i %% 3 == 0

  render: ->
    DOM.div
      className: "row"
      @createCards()

########################################
## ReactDOM.render function
########################################
create_card_container = (dom_element) ->
  # json_parsed_content = JSON.parse( source.dataset.imagesource )
  imageSource = dom_element.dataset.imageSource
  # imageSource = if decodeURIComponent(imageSource).match(/src=\"(.*)\"/) then decodeURIComponent(imageSource).match(/src=\"(.*)\"/)[1]
  imageClass = dom_element.dataset.imageClass
  imageAltInitial = dom_element.dataset.imageAlt.replace(/^\s+|\s+$/g,'')
  # Get rid of the extra wrapping span added by the Engine on editable_text
  imageAltInitial = if imageAltInitial.match(/\>(.*)\</) then imageAltInitial.match(/\>(.*)\</)[1].replace(/^\s+|\s+$/g,'') else imageAltInitial.replace(/^\s+|\s+$/g,'')
  imgBoxClass = dom_element.dataset.imageBoxClass
  ReactDOM.render(
    React.createElement CardContainer,
      imageSource: imageSource
      imageClass: imageClass
      imageAltInitial: imageAltInitial
      imgBoxClass: imgBoxClass
    dom_element
  )

########################################
# Init and loop over various React tags
########################################

$ ->
  dom_element = document.getElementsById("reactCardContainer")
  create_light_box_with dom_element
