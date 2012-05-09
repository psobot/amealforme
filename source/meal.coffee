inputs = null

$ ->
  inputs = $('ol.ingredients li input')
  inputs.keyup -> $('.error').fadeOut 'slow'
  
  $('form.choose').submit (e) ->
    fetch()
    e.preventDefault()

  $('.results button').click ->
    $('.results').fadeOut ->
      randomize()
      $('.choose').fadeIn()
  randomize()

randomize = ->
  inputs.val -> ""
  inputs.attr "placeholder", (i, e) ->
    random ingredients[i]
  inputs[0].focus()

random = (arr) ->
  arr[Math.floor(Math.random() * arr.length)]

createQuery = ->
  l = []
  inputs.each (i, e) ->
    if $(e).val() == ""
      l.push $(e).attr 'placeholder'
    else
      l.push $(e).val()
  l.join ' '

fetch = ->
  $.ajax
    url: "http://petersobot.com/recipes?jsonp=?",
    dataType: 'json',
    data: {count: 2, q: createQuery()},
    success: (data) ->
      if data.count
        $('.choose').fadeOut ->
          $.each data.recipes[0], (k, v) ->
            sel = $("._#{k}")
            if sel.length
              if sel.data('update')
                sel.attr sel.data('update'), v
              else
                sel.html v
          $('.error').fadeOut 'slow'
          $('.results').fadeIn()
      else # could happen if no result or throttling
        error()

error = ->
  $('.error').fadeIn 'slow'
  randomize()
  setTimeout ->
    $('.error').fadeOut 'slow'
  , 2000
