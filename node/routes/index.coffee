models = require("../models/cards")

# index
exports.index = (req, res) ->
  res.send 'Hello, World. Express!'
  return

# API
exports.api = (req, res) ->
  @players = req.params.players
  @model = new models.Cards.Game(@players)
  @hands = @model.deal()

  console.log(@hands)

  res.send @hands
  return