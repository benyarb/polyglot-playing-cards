# Author: Ben Yarbrough
# Requires Underscore.js - http://underscorejs.org


#------------------
# Views
#------------------

App = {}

# View(s) will be appended to this element
App.rootElement = $('#card-table')[0]

# Loop through players and hands for card display
# <% %> ERB-style delimiters
# underscore's _.each function: http://underscorejs.org/#each
App.views = "
    <% _.each(hands, function(hand, player) { %>
      <div class='well span5'>
        <h2>Player <%= player + 1 %></h2>
        
        <div class='hand'>
          <% _.each(hand, function(card) { %>
            <span class='card <%= card.suit.name() %>'>
              <span class='rank'><%= card.rank.letter() %></span>
              <span class='suit'>&<%= card.suit.name() %>;</span>
            </span>
          <% }); %>
        </div>
      </div>
    <% }); %>
  "

  
#------------------
# Events
#------------------

$ ->
  # Play Button
  $('#play').click ->
    language = $('#choose-language').val()
    players = $('#choose-players').val()

    
    # Concat api url
    url = 'http://' + language + '.benyarbrough.com/playing-cards/api/' + players

    $.getJSON url, (hands) ->
      # Make sure the table is clear
      $(App.rootElement).empty()
      
      # Underscore templating: http://underscorejs.org/#template
      table = _.template(App.views, {hands : hands})
  
      # Go!
      $(App.rootElement).append(table)

      return
    return
  return
