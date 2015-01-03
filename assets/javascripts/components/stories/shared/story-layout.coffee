React = require("react")
{div, aside, main} = React.DOM

MainMenu        = require("../../shared/main-menu")
SideMenu        = require("../../shared/side-menu")
navigationItems = require("../../shared/side-menu/navigation-items")

StoryLayout = React.createClass
  displayName: "story-layout"

  render: ->
    div {className: "story-layout"},
      div {id: "above-content"},
        MainMenu({navigationItems})

      aside {id: "aside-content"},
        SideMenu({navigationItems})

      main {className: "container", id: "main-content"}, @props.children

module.exports = StoryLayout
