$ ->
  window.resman.save_counter = 0

  $('body').on 'auto-saving', ->
    $('#autosave .saved').removeClass 'active'
    $('#autosave .saving').addClass 'active'
    window.resman.save_counter++

  $('body').on 'auto-saved', ->
    window.resman.save_counter--
    if (window.resman.save_counter == 0)
      $('#autosave .saving').removeClass 'active'
      $('#autosave .saved').addClass 'active'
      setTimeout ->
        $('#autosave .saved').removeClass 'active'
      , 2000

  $('body').on 'auto-error', ->
    $('
      #autosave .saved,
      #autosave .saving
      ').removeClass 'active'
    $('#autosave .error').addClass 'active'

