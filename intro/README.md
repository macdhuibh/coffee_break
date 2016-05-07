# Coffee Break Riot.js


## What is our Problem?
- We have pages that need to be quick and interactive
    - See Liga Inan & Openly Dashboards
- We deal with a lot of forms and formsets suck.
    - See Openly Editor
- We live in a high latency environment and page reloads can suck
    - Try loading a webpage now!


## What is our solution?
Using one of the fancy new javascript front end libraries


## What are some possible webby solutions?
### The leading contenders
- React.js
- Angular.js
- Ember.js
- Vue.js
- Backbone.js
- ihatetheworldofjavascript.js
- *Riot.js*


## What does Riot give you?
- Reactive frontend goodness
- Nice Django-like templates
- Webcomponents (Tags)
- Pleasant syntax .. for javascript


## The setup

1) [Download Riot.js](http://riotjs.com/download/)
2) Chuck it in a static folder

    └── static
        └── js
            └── riot+compiler.min.js

3) Create a view, url, and a template
4) Play!


## Setups Django

1) Add to views.py and chuck a few tweets in the context

    class Index(TemplateView):
        template_name = "tweety/index.html"

        def get_context_data(self, *args, **kwargs):
            context['tweets'] = {'tweets': [{'tweet': 'blah', },
                                            {'tweet': 'blah blah', },
                                            {'tweet': 'blah blah blah', },
                                            {'tweet': 'blah blah blah blah', },
                                            ]}
            return context

2)  Don't forget to add add to urls.py

    urlpatterns = [
        url(r'^$', views.Index.as_view(), name='index'),
    ]

3)  Django is a Riot

        <tweet></tweet>

        <script type="riot/tag" src="{% static 'js/tweet.tag' %}"></script>
        <script>
            opts = {{ tweets|safe }} // initial tweets come from Django template tag
            riot.mount('tweet', opts)
        </script>

4) Create a Riot Tag and put it in static


    └── static
        └── js
            ├── riot+compiler.min.js
            └── tweet.tag


### Play with Riot.js or The anatomy of of a Riot tag

*Tags* - Riot bundles structure, behavior, and style in a single place.

### The Whole Tag

    <tweet>
      <h3>{ message } <label class='badge'>{ tweets.length }</label></h3>

      <form onsubmit={ add }>
        <input name="input" onkeyup={ edit } size='60'>
        <button class="btn" disabled={ !text }>Add</button>
        <div>characters left: {60 - counter}</div>
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

      <script>
        this.message = 'Tweets'
        this.counter = 0
        this.tweets = opts.tweets // you can get opts from the mount() function

        edit(e) {
          this.text = e.target.value
          this.counter = this.text.length
        }

        add(e) {
          if (this.text) {
            this.tweets.push({ tweet: this.text }) // imagine an AJAX Call around here
            this.text = this.input.value = ''
          }
        }
      </script>
    </tweet>


### The HTML looking bit

#### Mustaches
Riot has it's own Django-like Template language. No DOM manipulation necessary

    <h3>{ message } <label class='badge'>{ tweets.length }</label></h3>

#### Forms are fun.

    <form onsubmit={ add }>
        <!- Add actions with a mustache -->
        <input name="input" onkeyup={ edit } size='60'>
        <button disabled={ !text }>Add</button>
        <!- negation is a thing -->
        <div>characters left: {60 - counter}</div>
        <!- calculate in place. It's just javascript. -->
    </form>

Scripting is easy

    edit(e) {
      this.text = e.target.value
      this.counter = this.text.length
    }


#### Loops are Fun
Given an array like structure. Riot can just loop through.

    <li each={ tweets }>
        <p>{ tweet }</p>
    </li>

Adding elements is easy

    add(e) {
      if (this.text) {
        this.tweets.push({ tweet: this.text })
        // imagine an AJAX Call around here
      }
    }


