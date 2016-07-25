class App.views.UserEditView extends Marionette.ItemView
  template: '#user_edit_tpl'
  errorTemplate: _.template($('#form_error_tpl').html())
  formGroupSelector: ".form-group"
  errorFormGroupClass: "has-error"
  errorBlockSelector: ".help-block"
  animationDuration: 300

  initialize: ->
    _.bindAll(@, "onSuccess", "onError")

  events:
    'submit form' : 'onSubmit',
    'focus form .form-control': 'onFieldFocus'
    'blur form .form-control': 'onFieldBlur'
    'change form .radio input[type="radio"]': 'onRadioChange'

  onFieldFocus: (e) ->
    $(e.target).closest(@formGroupSelector).children("label").addClass("active")

  onFieldBlur: (e) ->
    $(e.target).closest(@formGroupSelector).children("label").removeClass("active")

  onRadioChange: (e) ->
    $(e.target).closest(@formGroupSelector).find(".radio label.active")
      .removeClass("active")
    $(e.target).closest("label")
      .addClass("active")

  onDomRefresh: ->
    @$form = @$el.find("form")
    @$form.find(".radio input[type='radio']:checked")
      .trigger("change")

  collectFormData: ->
    @$form.serializeJSON()

  onSubmit: (e) ->
    e.preventDefault()
    @clearErrors()
    @model.save(@collectFormData(),
      wait: true
      success: @onSuccess
      error: @onError
    )

  onSuccess: ->
    App.modal.hideModal()

  onError: (model, xhr) ->
    if xhr?.responseJSON?.children
      # starting recursively check fields in response for errors and build
      # field id starting from 'user'
      @checkField(xhr.responseJSON, ['user'])

  checkField: (field, nameChain) ->
    if field.errors?
      @showFieldErrors(nameChain, field.errors)
    for childName, child of field.children
      @checkField(child, nameChain.concat([childName]))

  showFieldErrors: (nameChain, messages) ->
    fieldId = nameChain.join("_")
    $formGroup = $("#" + fieldId).closest(@formGroupSelector)
    $formGroup.addClass(@errorFormGroupClass)
    for msg in messages
      $errorBlock = $(@errorTemplate({msg: msg}))
      $errorBlock.hide()
      $formGroup.append($errorBlock)
      $errorBlock.slideDown(@animationDuration)
      $('#modal').find('.modal-body').scrollTo($formGroup, @animationDuration)

  clearErrors: ->
    @$form.find(@formGroupSelector).removeClass(@errorFormGroupClass)
    @$form.find(@errorBlockSelector).remove()
