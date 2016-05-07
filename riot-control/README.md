## What is Riot-Control
- Riot-Control builds on Riot's event system.
- With it we can make a simple and clean abstraction between storage and UI.
- It is also super lightweight, only 17 lines of code.


## Why would I want to use this?
- We are moving to a world where we use both server side and client side persistence. 
- Riot-Control helps Devs work on UI and other Devs working on Storage and generating stats without stepping on eachother's toes
- Web components can share data nicely!

## What does this look like? (by example)

We separate our concerns:

- We use our [HTML template](coffee_break/tweety/templates/tweety/index.html) as the hub
- We use riot.js tags to create [our web components](coffee_break/tweety/templates/tweety/tweet.tag)
- We have a new Javascript file to [manage storage](coffee_break/tweety/js/tweetstore.js)

We use Riot-control and Riots events to talk with each other.


## What does our little example do?!

After we have setup everything...

- The Tweet is mounted on the page
- The Tweet tag is populated with tweets from the Django Context
- A user adds a tweet
    - The Tweet Tag
        - emits a `tweet_add` event and trusts that something will happen
        - Cleans up the UI as needed (i.e. cleans up the text input box)
    - The TweetStore listens for the `tweet_add` event
        - Post the new tweet to our RESTful API
        - On success
            - The store updates the list of `tweets`
            - Then emits an `tweets_changed` event
    - The Tweet Tag
        - Listens for `tweets_changed` event
        - Re-draws itself


## Show me some code already!

### index.html
A little bit of setup.  We plop in our `tweet` tag and we do a little initialization

    <tweet></tweet>

    <script>
        // initial tweets come from Django template tag
        var tweets = {{ tweets|safe }} 

        // Create a store instance.
        var tweetStore = new TweetStore(tweets) 

        // Register the store in central dispatch and mount.
        RiotControl.addStore(tweetStore) 
        riot.mount('tweet')
    </script>


### tweet.tag
Display the Tweets

    <ul>
        <li each={ tweets }>
            <p>{ tweet }</p>
        </li>
    </ul>


Wire in `RiotControl`

    self.on('mount', () => {
        // Trigger init event when component is mounted to page.
        // Any store could respond to this.
        RiotControl.trigger('tweet_init')
    })  


The `tweet` tag can listen for changes, update and then redraw itself

    // Register a listener for store change events.
    RiotControl.on('tweets_changed', tweets => {
        self.tweets = tweets
        self.update()
    })


The `add` function emits a `tweet_add` event and does a little clean up

    add(e) {
        if (self.text) {
            // Trigger event to all stores registered in central dispatch.
            // This allows loosely coupled stores/components to react to same events.
            RiotControl.trigger('tweet_add', { 'tweet': self.text })

            self.text = self.input.value = ''
        }
    }


### The Tweetstore

Any number of views can emit actions/events without knowing the specifics of the back-end. This store can easily be swapped for another, while the view components remain untouched.

The TweetStore listens for the `tweet_add` events. When it hears one it'll post the new tweet to our RESTful API. On success, the store updates the list of `tweets` and emits an `tweets_changed` event.  Good thing the `tweet` tag is listening, ready to update itself.
 

    function TweetStore(tweets) {
        riot.observable(this) // Riot provides our event emitter.
        this.tweets = tweets;

        this.on('tweet_add', newTweet => {
            $.post('/api/tweet/', newTweet, result => {
                this.tweets.push(result)
                this.trigger('tweets_changed', self.tweets)
            })
        })
    }
