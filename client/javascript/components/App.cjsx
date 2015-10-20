React = require 'react'
Store = require '../stores/todo'

Header = require './Header'
MainSection = require './MainSection'
Footer = require './Footer'

TodoApp = React.createClass(
  getInitialState: ->
    allTodos: Store.getAll()
    areAllComplete: Store.areAllComplete()

  componentDidMount: ->
    Store.addChangeListener(@_changeListener)

  componentWillUnmount: ->
    Store.removeChangeListener(@_changeListener)

  _changeListener: ->
    @setState
      allTodos: Store.getAll()
      areAllComplete: Store.areAllComplete()

  render: ->
    return (
      <div id="todoapp">
        <Header />
        <MainSection
          allTodos={@state.allTodos}
          areAllComplete={@state.areAllComplete}
        />
        <Footer allTodos={@state.allTodos} />
      </div>
    )
)

module.exports = TodoApp
