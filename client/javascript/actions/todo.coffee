Dispatcher = require '../dispatchers/todo'
Constant = require '../constants/todo'

TodoActions =
  create: (text) ->
    Dispatcher.dispatch(
      action: Constant.CREATE
      text: text
    )

  complete: (id) ->
    Dispatcher.dispatch(
      action: Constant.COMPLETE
      id: id
    )

  toggleComplete: (todo) ->
    action = if todo.complete then Constant.UNDO_COMPLETE else Constant.COMPLETE

    Dispatcher.dispatch(
      action: action
      id: todo.id
    )

  updateText: (id, newText) ->
    Dispatcher.dispatch(
      action: Constant.UPDATE_TEXT
      id: id
      text: newText
    )

  destroy: (id) ->
    Dispatcher.dispatch(
      action: Constant.DESTROY
      id: id
    )

  destroyCompleted: ->
    Dispatcher.dispatch(
      action: Constant.DESTROY_COMPLETED
    )

  toggleCompleteAll: ->
    Dispatcher.dispatch(
      action: Constant.TOGGLE_COMPLETE_ALL
    )

module.exports = TodoActions
