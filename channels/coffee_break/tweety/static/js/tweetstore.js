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
      { tweet: 'Please Add a Tweet',},
    ]
  }
  
self.on('tweet_append', function(newTweet) {
    self.tweets.push(newTweet)
    self.trigger('tweets_changed', self.tweets)
  })

  self.on('tweet_add', function(newTweet) {
    $.post('/api/tweet/', newTweet, function(result) {
        socket.send(result['tweet'])
        self.trigger('tweets_changed', self.tweets)
    })
  })

  self.on('tweet_init', function() {
    self.trigger('tweets_changed', self.tweets)
  })

  // The store emits change events to any listening views, so that they may react and redraw themselves.

}
