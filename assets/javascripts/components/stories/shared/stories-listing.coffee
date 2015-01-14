# Table of stories.
# Arguments:
# * Stories: Array.

React = require("react")

{Link}    = require("react-router")
HumanTime = require("../../shared/human-time")
Modal     = require("../../shared/modal")

Internuncio = require("internuncio")
logger      = new Internuncio("Story Listing")

StoryList = React.createClass
  displayName: "stories-listing"

  render: ->
    <table className="table stories">
      <thead>
        <th className="id">ID</th>
        <th className="title">Title</th>
        <th className="description">Description</th>
        <th className="updated-at">Updated</th>
        <th className="created-at">Created</th>
        <th className="delete-story">Delete</th>
      </thead>

      <tbody>{
        for id, story of @props.stories
          @rowRender(id, story)
      }</tbody>
    </table>

  rowRender: (id, story) ->
    <tr data-id=id key=id>
      <td className="id">{id}</td>

      <td className="title">
        <Link to="story" params={{id: id}}>{story.title or "untitled"}</Link>
        <Link to="story-edit" params={{id: id}}>(edit)</Link>
      </td>

      <td className="description">{story.description}</td>

      <td className="updated-at">
        <HumanTime datetime={story.updatedAt} />
      </td>

      <td className="created-at">
        <HumanTime datetime={story.createdAt} />
      </td>

      <td className="link delete-story" onClick={@confirmDeleteRender.bind(this, id, story)}>
        Delete
      </td>
    </tr>

  confirmDeleteRender: (id, story) ->
    actions = <div>
      <span className="btn dark btn-danger" onClick={@deleteStory.bind(this, id)}>Yes</span>
      <span className="btn dark btn-primary" data-dismiss="modal">No</span>
    </div>

    confirmationModal = <Modal title="Confirm Deletion" type="warning", actions={actions}>
      <p key="text">{"Are you sure you want to delete"}</p>
      <p key="title">{'"' + story.title + '"?'}</p>
    </Modal>

    React.render(confirmationModal, document.querySelector("#above-content"))

  deleteStory: (id) ->
    storyRef = @props.storiesRef.child(id)
    storyRef.remove (error) =>
      if error
        logger.error(error)
      else
        @props.onChange()

module.exports = StoryList
