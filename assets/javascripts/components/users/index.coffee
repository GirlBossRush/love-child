# Table of users.
# Arguments:
# * Users: Backbone Collection.

documentHelper = require("../../lib/document-helper")
React          = require("react")
R              = React.DOM

HumanTime      = require("../shared/human-time")
Modal          = require("../shared/modal")

usersList = React.createClass
  displayName: "users-list"

  render: ->
    R.table {className: "table users"},
      R.thead null,
        R.th {className: "id"}, "ID"
        R.th {className: "name"}, "Name"
        R.th {className: "email"}, "Email"
        R.th {className: "name"}, "Name"
        R.th {className: "created-at"}, "Created At"
        R.th {className: "delete-user"}, "Delete"
      R.tbody null, @props.collection.map(@rowRender)

  rowRender: (user) ->
    R.tr {"data-id": user.id, key: user.id},
      R.td {className: "id"}, user.id
      R.td {className: "name"}, user.name
      R.td {className: "email"}, user.email
      R.td {className: "created-at"},
        HumanTime(datetime: user.created_at)
      R.td {className: "link delete-user", onClick: @confirmDeleteRender.bind(this, user)}, "Delete"

  confirmDeleteRender: (user) ->
    confirmationModal = Modal
      title: "Confirm Deletion"
      type: "warning"

      body: [
        R.p {key: "text"}, "Are you sure you want to delete"
        R.p {key: "title"}, '"' + user.title + '"?'
      ]

      actions: [
        R.span {
          className: "btn dark btn-danger"
          key: "delete"
          onClick: @delete.bind(this, user.id)
          "data-dismiss": "modal"
        }, "Yes"

        R.span {
          className: "btn dark btn-primary"
          key: "cancel"
          "data-dismiss": "modal"
        }, "No"
      ]

    documentHelper.render
      anchor: "aboveContent"
      component: confirmationModal

  navigateUser: (href, e) ->
    e.preventDefault()
    documentHelper.navigate href, true

  delete: (id) ->
    model = @props.collection.get(id)

    model.destroy
      success: (model) =>
        @props.collection.remove(model)
        @forceUpdate()

        documentHelper.title = "(#{@props.collection.length}) users"

module.exports = usersList
