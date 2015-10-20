React = require 'react'
ReactPropTypes = React.PropTypes
Action = require '../actions/todo'

Footer = React.createClass(
  propTypes:
    allTodos: ReactPropTypes.object.isRequired

  _clearCompleted: ->
    Action.destroyCompleted()

  render: ->
    total = Object.keys(@props.allTodos).length

    return null if total < 1

    completed = 0
    for id of @props.allTodos
      completed++ if @props.allTodos[id].complete

    left = total - completed
    leftPhrase = if left > 1 then ' items ' else ' item '
    leftPhrase += 'left'

    if completed > 0
      clearCompletedBtn =
        <button
          id="clear-completed"
          onClick={@_clearCompleted}
        >
          Clear completed ({completed})
        </button>

    return (
      <footer id="footer">
        <span id="todo-count">
          <strong>{left}</strong>
          {leftPhrase}
        </span>
        {clearCompletedBtn}
      </footer>
    )
)

module.exports = Footer
