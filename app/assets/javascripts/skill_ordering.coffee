$ ->
  $shapeshiftcontainer = $('.shapeshift-container')
  if $shapeshiftcontainer.children().length > 0
    $shapeshiftcontainer
      .shapeshift({
        selector: '.edit_skill'
        handle: '.drag'
      })
      .on 'ss-rearranged', ->
        $container = $(this)
        $skill_order = $('#skill-order')
        order = []
        $container.find('.skill').each ->
          $skill = $(this)
          order.push $skill.data('id')
        json_order = JSON.stringify(order)
        if (json_order != $skill_order.val())
          $skill_order.val json_order
          $skill_order.closest('form').submit()

  $('.drag').on 'click', ->
    return false
