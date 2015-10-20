React = require 'react'
ReactPropTypes = React.PropTypes
Action = require '../actions/todo'
classNames = require 'classnames'

TextInput = require './TextInput'

Item = React.createClass(
  propTypes:
    todo: ReactPropTypes.object.isRequired

  getInitialState: ->
    isEditing: false

  _toggleComplete: ->
    Action.toggleComplete @props.todo

  _switchToEdit: ->
    @setState {isEditing: true}

  _update: (newText)->
    Action.updateText @props.todo.id, newText
    @setState {isEditing: false}

  _destroy: ->
    Action.destroy @props.todo.id

  render: ->
    return (
      <li
        className={classNames(
          'completed': @props.todo.complete
          'editing': @state.isEditing
        )}
        key={@props.todo.id}
      >
        <div className="view">
          <input
            className="toggle"
            type="checkbox"
            checked={@props.todo.complete}
            onChange={@_toggleComplete}
          />
          <label onDoubleClick={@_switchToEdit}>{@props.todo.text}</label>
          <button className="destroy" onClick={@_destroy}></button>
        </div>
        <TextInput
          className="edit"
          value={@props.todo.text}
          onSave={@_update}
        />
      </li>
    )
)

module.exports = Item
