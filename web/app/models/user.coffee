class App.models.User extends Backbone.Model
  urlRoot: '/app_dev.php/process-form'

  methodUrl:
    'read': '/app_dev.php/user',

  initialize: ->
    @fetch()

  sync: (method, model, options) ->
    options = options ? {}
    options.url = model.methodUrl[method.toLowerCase()] if model?.methodUrl?[method.toLowerCase()]
    Backbone.sync(method, model, options)
