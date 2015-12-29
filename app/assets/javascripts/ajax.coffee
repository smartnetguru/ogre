$ ->
  $([
    'form.edit_resume',
    'form.edit_job',
    'form.edit_skill',
    'form.edit_responsibility',
    'form.edit_project'
  ]).each (index, form_class) ->
    $(form_class)
      .on 'ajax:beforeSend', ->
        $('body').trigger 'auto-saving'
      .on 'ajax:success', (xhr, data, textStatus) ->
        $('body').trigger 'auto-saved'
      .on 'ajax:error', (xhr, textStatus, errorThrown) ->
        $('body').trigger 'auto-error'
        console.log 'ajax:error'
    $("#{form_class} input").on 'change', ->
      $(this).submit()

