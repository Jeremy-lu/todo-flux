React = require 'react'
TodoApp = require('./App')
ReactDOM = require 'react-dom'

module.exports = ReactDOM.render(
  <TodoApp />,
  document.getElementById 'todoapp'
)
