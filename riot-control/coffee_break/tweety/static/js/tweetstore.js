// TweetStore definition. (from TodoStore)
// Flux stores house application logic and state that relate to a specific domain.
// In this case, a list of todo items.
function TweetStore(tweets) {
  riot.observable(this) // Riot provides our event emitter.
  
  var self = this

  if (tweets) {   // If we get some tweets from the context use them
    self.tweets = tweets;
  } else {  // Otherwise use this little list of tweets instead
    self.tweets = [
      { tweet: 'Tweet 1',},
      { tweet: 'Tweet 2',}
    ]
  }
  

  // Our store's event handlers / API.
  // This is where we would use AJAX calls to interface with the server.
  // Any number of views can emit actions/events without knowing the specifics of the back-end.
  // This store can easily be swapped for another, while the view components remain untouched.

  self.on('tweet_add', function(newTweet) {
    // Post the new tweet to the RESTful API
    // If we are successfull add the new tweet to the list of tweets
    // and trigger an event to let the tag update itself with the new tweets
    $.post('/api/tweet/', newTweet, function(result) {
        self.tweets.push(result)
        self.trigger('tweets_changed', self.tweets)
    })
  })

  self.on('tweet_init', function() {
    self.trigger('tweets_changed', self.tweets)
  })

  // The store emits change events to any listening views, so that they may react and redraw themselves.

}
