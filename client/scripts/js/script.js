// Generated by CoffeeScript 1.3.3
(function() {
  var App;

  App = {};

  App.rootElement = $('#card-table')[0];

  App.view = "    <% _.each(hands, function(hand, player) { %>      <div class='well span5'>        <h2>Player <%= player + 1 %></h2>                <div class='hand'>          <% _.each(hand, function(card) { %>            <span class='card <%= card.suit.name() %>'>              <span class='rank'><%= card.rank.letter() %></span>              <span class='suit'>&<%= card.suit.name() %>;</span>            </span>          <% }); %>        </div>      </div>    <% }); %>  ";

  $(function() {
    $('#play').click(function() {
      var language, players, url;
      language = $('#choose-language').val();
      players = $('#choose-players').val();
      url = 'http://' + language + '.benyarbrough.com/playing-cards/api/' + players;
      $.getJSON(url, function(hands) {
        var table;
        $(App.rootElement).empty();
        log(hands);
        table = _.template(App.view, {
          hands: hands
        });
        $(App.rootElement).append(table);
      });
    });
  });

}).call(this);
