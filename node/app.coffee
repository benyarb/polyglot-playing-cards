# Module dependencies.
express = require("express")
routes = require("./routes")

app = module.exports = express.createServer()

# Configuration
app.configure ->
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use app.router
  return

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  return

app.configure "production", ->
  app.use express.errorHandler()
  return

# Routes
app.get "/", routes.index
app.get "/playing-cards/api/:players([1-8])", routes.api

# Go
app.listen process.env.VCAP_APP_PORT or 3000, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env
  return