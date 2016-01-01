$ ->
  $('.shapeshift-container').shapeshift({
    selector: '.edit_skill'
    handle: '.drag'
  })

  $('.drag').on 'click', ->
    return false
