# Reading preference controls.
# Updates user preferences for story reading .
# Arguments:
# * storyComponent: React Component

React = require("react")
{span, div, input} = React.DOM

userPreferences = require("../../../../helpers/user-preferences")

preferenceToInt =
  paragraphWidth:
    normal: 0
    wider:  1
    full:   2

  fontSize:
    smaller: 0
    normal:  1
    larger:  2

intToPreference =
  paragraphWidth:
    0: "normal"
    1: "wider"
    2: "full"

  fontSize:
    0: "smaller"
    1: "normal"
    2: "larger"

module.exports = React.createClass
  displayName: "reading-preferences"

  render: ->
    {paragraphWidth, fontSize} = userPreferences.stories

    div {className: "reading-preferences"},
      div {className: "preference paragraph-width"},
        span {className: "glyphicon glyphicon-resize-horizontal preference-label"}
        input
          className: "slider"
          type: "range"
          min: 0
          max: 2
          value: preferenceToInt.paragraphWidth[paragraphWidth]

          onChange: @handlePreferenceChange.bind(this, "paragraphWidth")

      div {className: "preference font-size"},
        span {className: "glyphicon glyphicon-resize-vertical preference-label"}
        input
          className: "slider"
          type: "range"
          min: 0
          max: 2
          value: preferenceToInt.fontSize[fontSize]

          onChange: @handlePreferenceChange.bind(this, "fontSize")

  handlePreferenceChange: (type, e) ->
    value = parseInt(e.target.value, 10)

    userPreferences.stories[type] = intToPreference[type][value]
    @props.storyComponent.forceUpdate()
