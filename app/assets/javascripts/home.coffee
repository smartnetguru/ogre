$ ->
  return if $('#home-page.container').length == 0

  $('.accordion').accordion
    header: '.accordion-header'
    collapsible: true
    active: false
