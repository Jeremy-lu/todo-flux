React = require 'react'
ReactPropTypes = React.PropTypes
Action = require '../actions/todo'
Item = require './Item'

MainSection = React.createClass(
  propTypes:
    allTodos: ReactPropTypes.object.isRequired
    areAllComplete: ReactPropTypes.bool.isRequired

  _toggleCompleteAll: ->
    Action.toggleCompleteAll()

  render: ->
    return null if Object.keys(@props.allTodos).length < 1

    todoList = for id of @props.allTodos
      <Item key={id} todo={@props.allTodos[id]} />

    return (
      <section id="main">
        <input
          id="toggle-all"
          type="checkbox"
          onChange={@_toggleCompleteAll}
          checked={if @props.areAllComplete then 'checked' else ''}
        />
        <ul id="todo-list">{todoList}</ul>
      </section>
    )
)

module.exports = MainSection
