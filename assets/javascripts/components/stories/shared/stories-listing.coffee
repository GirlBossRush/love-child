# Table of stories.
# Arguments:
# * Stories: Backbone Collection.

React = require("react")
{table, thead, th, tbody, tr, td, span, p} = React.DOM

{Link}    = require("react-router")
HumanTime = require("../../shared/human-time")
Modal     = require("../../shared/modal")

Internuncio = require("internuncio")
logger      = new Internuncio("Story Listing")

StoryList = React.createClass
  displayName: "stories-listing"

  render: ->
    table {className: "table stories"},
      thead null,
        th {className: "id"}, "ID"
        th {className: "title"}, "Title"
        th {className: "description"}, "Description"
        th {className: "updated-at"}, "Updated"
        th {className: "created-at"}, "Created"
        th {className: "delete-story"}, "Delete"
      tbody null,
        for id, story of @props.stories
          @rowRender(id, story)

  rowRender: (id, story) ->
    tr {"data-id": id, key: id},
      td {className: "id"}, id

      td {className: "title"},
        Link {to: "story", params: {id: id}}, story.title or "untitled"
        Link {to: "story-edit", params: {id: id}}, "(edit)"

      td {className: "description"}, story.description

      td {className: "updated-at"},
        HumanTime(datetime: story.updatedAt)

      td {className: "created-at"},
        HumanTime(datetime: story.createdAt)

      td {className: "link delete-story", onClick: @confirmDeleteRender.bind(this, id, story)}, "Delete"

  confirmDeleteRender: (id, story) ->
    confirmationModal = Modal
      title: "Confirm Deletion"
      type: "warning"

      body: [
        p {key: "text"}, "Are you sure you want to delete"
        p {key: "title"}, '"' + story.title + '"?'
      ]

      actions: [
        span {
          className: "btn dark btn-danger"
          key: "delete"
          onClick: @delete.bind(this, id)
          "data-dismiss": "modal"
        }, "Yes"

        span {
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
