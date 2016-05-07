{% load i18n %}

<tweet>
  <h3>{ message } <label class='badge'>{ tweets.length }</label></h3>

  <form onsubmit={ add }>
    <input name="input" onkeyup={ edit } size='60'>
    <button class="btn" disabled={ !text }>{% trans 'Add' %}</button>
    <div>characters left: { max_length - counter }</div>
  </form>

  <ul>
    <li each={ tweets }>
      <div class="panel panel-default">
        <div class="panel-body">
          <p>{ tweet }</p>
        </div>
      </div>
    </li>
  </ul>

  <style scoped>
    :scope { font-size: 2rem }
    h3 { color: #444 }
    ul { font-size: 1rem }
    li { list-style-type: none }
  </style>

  var self = this
  self.message = 'Tweets'
  self.counter = 0
  self.max_length = 256
  
  self.on('mount', function() {
    // Trigger init event when component is mounted to page.
    // Any store could respond to this.
    RiotControl.trigger('tweet_init')
  })  

  // Register a listener for store change events.
  RiotControl.on('tweets_changed', function(tweets) {
    self.tweets = tweets
    self.update()
  }) 

  edit(e) {
    self.text = e.target.value
    self.counter = self.text.length
  }

  add(e) {
    if (self.text) {
      // Trigger event to all stores registered in central dispatch.
      // This allows loosely coupled stores/components to react to same events.
      RiotControl.trigger('tweet_add', { 'tweet': self.text })

      self.text = self.input.value = ''
    }
  }
</tweet>
