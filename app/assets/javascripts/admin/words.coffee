$(document).ready ->
  $(".answer-option").change ->
    $(".answer-option").prop("checked", false)
    $(this).prop("checked", true)

  $(document).on 'click', '.remove_fields', (event) ->
    if ($(".answer-option").length > 2)
      $(this).prev('input[type=hidden]').val('1')
      $(this).closest('.input-group').remove()
    else
      alert($('#at-least-two-answers-msg').val())
    event.preventDefault()

  $(document).on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $('#answers-block').append($(this).data('fields').replace(regexp, time))
    event.preventDefault()
