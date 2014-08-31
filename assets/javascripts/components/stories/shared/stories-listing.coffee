# Table of stories.
# Arguments:
# * Stories: Backbone Collection.

React          = require("react")
R              = React.DOM
Link           = require("react-router/link")

HumanTime      = require("../../shared/human-time")
Modal          = require("../../shared/modal")

Internuncio    = require("internuncio")
logger         = new Internuncio("Story Listing")

StoryList = React.createClass
  displayName: "stories-listing"

  render: ->
    R.table {className: "table stories"},
      R.thead null,
        R.th {className: "id"}, "ID"
        R.th {className: "title"}, "Title"
        R.th {className: "description"}, "Description"
        R.th {className: "created-at"}, "Created At"
        R.th {className: "delete-story"}, "Delete"
      R.tbody null,
        for id, story of @props.stories
          @rowRender(id, story)

  rowRender: (id, story) ->
    R.tr {"data-id": id, key: id},
      R.td {className: "id"}, id
      R.td {className: "title"},
        Link {to: "story", params: {id: id}}, story.title or "untitled"
        Link {to: "story-edit", params: {id: id}}, "(edit)"
      R.td {className: "description"}, story.description
      R.td {className: "created-at"},
        HumanTime(datetime: story.createdAt)
      R.td {className: "link delete-story", onClick: @confirmDeleteRender.bind(this, id, story)}, "Delete"

  confirmDeleteRender: (id, story) ->
    confirmationModal = Modal
      title: "Confirm Deletion"
      type: "warning"

      body: [
        R.p {key: "text"}, "Are you sure you want to delete"
        R.p {key: "title"}, '"' + story.title + '"?'
      ]

      actions: [
        R.span {
          className: "btn dark btn-danger"
          key: "delete"
          onClick: @delete.bind(this, id)
          "data-dismiss": "modal"
        }, "Yes"

        R.span {
          className: "btn dark btn-primary"
          key: "cancel"
          "data-dismiss": "modal"
        }, "No"
      ]

    React.renderComponent confirmationModal, document.querySelector("#above-content")

  delete: (id) ->
    # debugger
    storyRef = @props.storiesRef.child(id)
    storyRef.remove (error) =>
      if error
        logger.error(error)
      else
        @props.onChange()
      # success: (model) =>
      #   @props.stories.remove(model)
      #   @forceUpdate()

module.exports = StoryList
