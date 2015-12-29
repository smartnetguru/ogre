$ ->
  $('
    form.edit_resume,
    form.edit_job,
    form.edit_skill
    ')
    .on 'ajax:beforeSend', ->
      $('body').trigger 'auto-saving'
    .on 'ajax:success', (xhr, data, textStatus) ->
      $('body').trigger 'auto-saved'
    .on 'ajax:error', (xhr, textStatus, errorThrown) ->
      $('body').trigger 'auto-error'
      console.log 'ajax:error'

  $('
    #edit-resume input,
    form.edit_job input,
    form.edit_skill input
    ').on 'change', ->
    $(this).submit()
