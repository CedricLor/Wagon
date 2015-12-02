DOM = React.DOM

########################################
# Lgend component
########################################
Legend = React.createClass
  displayName: "Legend"

  render: ->
    DOM.p null, "#{@props.imageAlt}"

########################################
# Image component
########################################
Image = React.createClass
  displayName: "Image"

  render: ->
    DOM.img
      src: @props.imageSource
      className: "#{@props.imageClass} img-thumbnail"
      alt: @props.imageAlt
      onClick: @props.handleClick

########################################
## LightBox compoenent
########################################
LightBox = React.createClass
  displayName: "LightBox"
  getInitialState: ->
    clicked: false
    imageAlt: @props.imageAltInitial

  getDefaultProps: ->
    lightBoxClass: {
      true: "lightbox",
      false: ""
    }
    imgSizeClass: {
      true: "img-enlarged",
      false: "img-belittled"
    }
    imageAltAddition: {
      true: "Enlarged ",
      false: ""
    }

  componentDidMount: ->
    @_subscribeToEvents() if window.parent.PubSub

  componentWillUnmount: ->
    @_unsubscribeFromEvents() if window.parent.PubSub

  _subscribeToEvents: ->
    window.parent.PubSub.subscribe 'inputs.text_changed', @_refreshText

  _unsubscribeFromEvents: ->
    PubSub.unsubscribe 'inputs.text_changed'

  _refreshText: (msg, data) ->
    if data.view.el.innerText.match(/LEGEND/)
      imageAlt = data.content
      @setState imageAlt: imageAlt

  _handleClickOnImg: (event) ->
    clicked = if @state.clicked == false then true else false
    @setState clicked: clicked

  _handleClickOnDiv: (event) ->
    clicked = if @state.clicked == true then @_handleClickOnImg()

  render: ->
    DOM.div
      onClick: @_handleClickOnDiv
      className: "#{@props.imgBoxClass} #{@props.lightBoxClass[@state.clicked]}"
      React.createElement Image,
        handleClick: @_handleClickOnImg
        imageSource: @props.imageSource
        imageClass: "#{@props.imageClass} #{@props.imgSizeClass[@state.clicked]}"
        imageAlt: "#{@state.imageAlt} #{@props.imageAltAddition[@state.clicked]}"
      React.createElement Legend,
        imageAlt: "#{@state.imageAlt} #{@props.imageAltAddition[@state.clicked]}"

########################################
## ReactDOM Render function
########################################
create_light_box_with = (dom_element) ->
  # json_parsed_content = JSON.parse( source.dataset.imagesource )
  imageSource = dom_element.dataset.imageSource
  # imageSource = if decodeURIComponent(imageSource).match(/src=\"(.*)\"/) then decodeURIComponent(imageSource).match(/src=\"(.*)\"/)[1]
  imageClass = dom_element.dataset.imageClass
  imageAltInitial = dom_element.dataset.imageAlt.replace(/^\s+|\s+$/g,'')
  # Get rid of the extra wrapping span added by the Engine on editable_text
  imageAltInitial = if imageAltInitial.match(/\>(.*)\</) then imageAltInitial.match(/\>(.*)\</)[1].replace(/^\s+|\s+$/g,'') else imageAltInitial.replace(/^\s+|\s+$/g,'')
  imgBoxClass = dom_element.dataset.imageBoxClass
  ReactDOM.render(
    React.createElement LightBox,
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
  dom_elements = document.getElementsByClassName("react-lightbox")
  create_light_box_with dom_element for dom_element in dom_elements
