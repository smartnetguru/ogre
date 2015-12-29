$ ->
  $('#autosave-saved').on 'click', ->
    $('#autosave .saved').toggleClass 'active'

  $('#autosave-saving').on 'click', ->
    $('#autosave .saving').toggleClass 'active'

  $('#autosave-error').on 'click', ->
    $('#autosave .error').toggleClass 'active'
