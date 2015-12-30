$ ->
  $('#facebook-login').on 'click', ->
    $(this).find('a').click()
    false
