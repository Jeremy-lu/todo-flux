React = require 'react'
Action = require '../actions/todo'
TextInput = require './TextInput'

Header = React.createClass(
  _onSave: (text) ->
    Action.create(text) if text and text.trim()

  render: ->
    return (
      <div id="header">
        <h1>Todos</h1>
        <TextInput
          id="new-todo"
          placeholder="What need to be done?"
          onSave={@_onSave}
          isCreate={true}
        />
      </div>
    )
)

module.exports = Header
