class Router extends Marionette.AppRouter
  routes:
    '': 'view'
  view: ->
    userView = new App.views.UserView
      model: App.user
    userEditView = new App.views.UserEditView
      model: App.user
    App.content.show(userView)
    App.modal.show(userEditView)

class ModalRegion extends Marionette.Region
  el: "#modal"
  attachHtml:(view) ->
    @$el.find(".modal-content").empty().append(view.el)
  hideModal: ->
    @$el.modal('hide')

App.addRegions
  content: '#content'
  modal:
    regionClass: ModalRegion
    selector: '#modal'

App.addInitializer (options) ->
  @user = new App.models.User()
  @router = new Router()
  Backbone.history.start()

App.start()
