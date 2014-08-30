# Table of stories.
# Arguments:
# * Stories: Backbone Collection.

documentHelper = require("../../../lib/document-helper")
React          = require("react")
R              = React.DOM
Link           = require("react-router/link")

HumanTime      = require("../../shared/human-time")
Modal          = require("../../shared/modal")

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
      R.tbody null, @props.stories.map(@rowRender)

  rowRender: (story) ->
    R.tr {"data-id": story.id, key: story.id},
      R.td {className: "id"}, story.id
      R.td {className: "title"},
        Link {to: "story", params: {id: story.id}}, story.title or "untitled"
        Link {to: "story-edit", params: {id: story.id}}, "(edit)"
      R.td {className: "description"}, story.description
      R.td {className: "created-at"},
        HumanTime(datetime: story.created_at)
      R.td {className: "link delete-story", onClick: @confirmDeleteRender.bind(this, story)}, "Delete"

  confirmDeleteRender: (story) ->
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
          onClick: @delete.bind(this, story.id)
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
    model = @props.stories.get(id)
    model.destroy
      success: (model) =>
        @props.stories.remove(model)
        @forceUpdate()
        @props.onChange()

module.exports = StoryList
