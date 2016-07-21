# In a large app we would use CommonJS, or other module management,
# but let's keep it simple for now using one global var.
App = new Marionette.Application()
App.models = {}
App.views = {}
window.App = App
