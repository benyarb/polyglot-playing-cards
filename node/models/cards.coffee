# Author: Ben Yarbrough

# Requires Underscore.js - http://underscorejs.org
_ = require("underscore")

# Assign global scope to the root variable
root = exports ? this
# Expose the Cards object
root.Cards = Cards = {}

#------------------
# Cards Models
#------------------

# Immutable singleton
class Cards.Rank
  constructor: (@value) ->

  letter: ->
    'A23456789TJQK'.charAt(@value)
  nextLower: ->
    if @value is 0 then null else Cards.ranks[@value - 1]
  nextHigher: ->
    if @value is 12 then null else Cards.ranks[@value + 1]

# Immutable singleton
class Cards.Suit
  constructor: (@value) ->

  letter: ->
    'CDHS'.charAt(@value) # clubs, diamonds, hearts, spades
  color: ->
    if @letter() is 'C' or @letter() is 'S' then 'black' else 'red'
  name: ->
    if @letter() is 'C'
      'clubs'
    else if @letter() is 'D'
      'diams'
    else if @letter() is 'H'
      'hearts'
    else
      'spades'


# Do not instantiate Rank and Suit; instead, use these:
Cards.ranks = (new Cards.Rank(i) for i in [0...13])
Cards.suits = (new Cards.Suit(i) for i in [0...4])

_nextId = 0

class Cards.Card
  constructor: (@rank, @suit) ->
    @id = "id#{_nextId++}"


class Cards.Game
  constructor: (@numberOfPlayers = 4) ->
    # Setup empty player hands, defaults to 4 players
    @players = ([] for i in [0...@numberOfPlayers])

    # Create a shuffled deck
    # Uses Fischer-Yates algorithm - http://bwy.me/4c
    # via Underscore.js - http://underscorejs.org/#shuffle
    @deck = _.shuffle(@createDeck())

  deal: ->
    deckCopy = @deck.slice(0)
    
    # Determine how many cards will be left-over
    spareCards = deckCopy.length % @numberOfPlayers

    # Deal the cards evenly
    while deckCopy.length - spareCards
      for i in [0...@players.length]
        @players[i].push(deckCopy.pop())

    # Stash the left-over cards
    @spareCards = deckCopy

    # Return players/hands/cards
    @players

  createDeck: ->
    # Underscore's flatten function: http://underscorejs.org/#flatten
    _.flatten(new Cards.Card(rank, suit) \
      for rank in Cards.ranks \
      for suit in Cards.suits)
  