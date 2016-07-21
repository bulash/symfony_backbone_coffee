class App.views.UserView extends Marionette.ItemView
  template: '#user_detail_tpl'

  initialize: ->
    @model.bind('change', @render)

  templateHelpers: ->
    model = @model
    field: (fieldName) ->
      model.get('user')?[fieldName]
    date: (fieldName) ->
      dateStr = model.get('user')?[fieldName]
      if dateStr
        moment(new Date(dateStr)).format("D MMMM YYYY")
    gender: (fieldName) ->
      gender = @field(fieldName)
      if gender?
        if gender is "0" then "Male" else "Female"
