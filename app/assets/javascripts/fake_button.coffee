$ ->
  $('.fake-anchor').on 'click', ->
    $this = $(this)
    url = $this.attr 'href'
    window.location.href = url
