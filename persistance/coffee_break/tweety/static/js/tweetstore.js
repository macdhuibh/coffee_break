// TweetStore definition. (from TodoStore)
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of todo items.
function TweetStore(tweets) {
  riot.observable(this); // Riot provides our event emitter.
  
  var self = this;

  if (tweets) {
    self.tweets = tweets;
  } else {
    self.tweets = [
      { tweet: 'Tweet 1',},
      { tweet: 'Tweet 2',}
    ];
  }
  

  // Our store's event handlers / API.
  // This is where we would use AJAX calls to interface with the server.
  // Any number of views can emit actions/events without knowing the specifics of the back-end.
  // This store can easily be swapped for another, while the view components remain untouched.

  self.on('tweet_add', function(newTweet) {
    $.post('/api/tweet/', newTweet, function(result) {
        self.tweets.push(newTweet);
        self.trigger('tweets_changed', self.tweets);
    });
  });

  self.on('tweet_init', function() {
    self.trigger('tweets_changed', self.tweets);
  });

  // The store emits change events to any listening views, so that they may react and redraw themselves.

}
