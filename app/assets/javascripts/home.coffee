$ ->
  $('.accordion').each ->
    $this = $(this)
    cookie_name = $this.attr 'id'
    state = resman.getCookie(cookie_name) == "true"
    $this.accordion
      header: '.accordion-header'
      collapsible: true
      active: if state then 0 else false
      heightStyle: 'content'
      activate: (event, ui) ->
        $this = $(this)
        cookie_name = $this.attr 'id'
        state = ($this.accordion('option', 'active') != false)
        resman.setCookie cookie_name, state, 1
