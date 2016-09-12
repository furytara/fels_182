$(document).on 'ready page:load', ->
  $(document).on 'change', '.answer-option', (event) ->
    $(".answer-option").prop("checked", "")
    $(".hidden_for_answer").val("false")
    $(this).prop("checked", "checked")
    $(this).next().val("true")

  $(document).on 'click', '.remove_fields', (event) ->
    if $(".answer-option:visible").length > 2
      if $(this).parent().parent().find('.hidden_for_answer').val() == 'true'
        alert $("#cannot-remove-correct-ans").val()
      else
        $(this).parent().prev('input[type=hidden]').val('true')
        $(this).closest('.input-group').hide()
    else
      alert $('#at-least-two-answers-msg').val()
    event.preventDefault()

  $(document).on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $('#answers-block').append($(this).data('fields').replace(regexp, time))
    event.preventDefault()
