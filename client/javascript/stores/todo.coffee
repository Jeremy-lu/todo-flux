Dispatcher = require '../dispatchers/todo'
Constant = require '../constants/todo'
EventEmitter = require('events').EventEmitter
merge = require 'merge'

CHANGE_EVENT = 'change'

_todos = {}

create = (text) ->
  id = new Date().getTime()
  _todos[id] =
    id: id
    text: text
    complete: false

update = (id, newInfo) ->
  _todos[id] = merge _todos[id], newInfo

destroy = (id) ->
  delete _todos[id]

updateAll = (newInfo) ->
  for id of _todos
    update id, newInfo

destroyCompleted = ->
  for id of _todos
    destroy(id) if _todos[id].complete


TodoStore = merge(EventEmitter.prototype,
  areAllComplete: ->
    for id of _todos
      return false if not _todos[id].complete
    true

  getAll: ->
    _todos

  emitChange: ->
    @emit CHANGE_EVENT

  addChangeListener: (cb) ->
    @on CHANGE_EVENT, cb

  removeChangeListener: (cb) ->
    @removeListener CHANGE_EVENT, cb
)

Dispatcher.register (payload) ->
  switch payload.action
    when Constant.CREATE
      create(payload.text) if payload.text isnt ''
    when Constant.COMPLETE
      update(payload.id, { complete: true })
    when Constant.UNDO_COMPLETE
      update(payload.id, { complete: false })
    when Constant.UPDATE_TEXT
      update(payload.id, { text: payload.text })
    when Constant.DESTROY
      destroy(payload.id)
    when Constant.DESTROY_COMPLETED
      destroyCompleted()
    when Constant.TOGGLE_COMPLETE_ALL
      if TodoStore.areAllComplete()
        updateAll({ complete: false })
      else
        updateAll({ complete: true })

  TodoStore.emitChange()

module.exports = TodoStore
