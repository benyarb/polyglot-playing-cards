// Generated by CoffeeScript 1.3.3
(function() {
  var app, express, routes;

  express = require("express");

  routes = require("./routes");

  app = module.exports = express.createServer();

  app.configure(function() {
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(app.router);
  });

  app.configure("development", function() {
    app.use(express.errorHandler({
      dumpExceptions: true,
      showStack: true
    }));
  });

  app.configure("production", function() {
    app.use(express.errorHandler());
  });

  app.get("/", routes.index);

  app.get("/api/:players([1-8])", routes.api);

  app.listen(process.env.VCAP_APP_PORT || 3000, function() {
    console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
  });

}).call(this);
