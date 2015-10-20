React = require 'react'
ReactPropTypes = React.PropTypes

ENTER_CODE = 13

TextInput = React.createClass(
  propTypes:
    id: ReactPropTypes.string
    className: ReactPropTypes.string
    value: ReactPropTypes.string
    onSave: ReactPropTypes.func.isRequired
    placeholder: ReactPropTypes.string

  getInitialState: ->
    value: @props.value or ''

  _handleKeyDown: (e) ->
    if e.keyCode is ENTER_CODE
      @_save()

  _handleChange: (e) ->
    @setState {value: e.target.value}

  _save: () ->
    value = @props.value
    if @state.value and @state.value.trim()
      value = @state.value.trim()
    else
      @setState(value: value)
    @props.onSave value
    @setState(value: '') if @props.isCreate

  render: ->
    return (
      <input
        id={@props.id}
        className={@props.className}
        value={@state.value}
        placeholder={@props.placeholder}
        onKeyDown={@_handleKeyDown}
        onChange={@_handleChange}
        onBlur={@_save}
        autoFocus={true}
      />
    )
)

module.exports = TextInput
