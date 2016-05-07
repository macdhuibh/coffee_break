{% load i18n %}

<tweet>
  <h3>{ message } <label class='badge'>{ tweets.length }</label></h3>

  <form onsubmit={ add }>
    <input name="input" onkeyup={ edit } size='{ max_length }'>
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

  this.message = 'Tweets'
  this.counter = 0
  this.max_length = 256
  this.tweets = opts.tweets // you can get opts from the mount() function

  edit(e) {
    this.text = e.target.value
    this.counter = this.text.length
  }

  add(e) {
    if (this.text) {
      post_text = { 'tweet': this.text }

      $.post('/api/tweet/', post_text, function(result) {
        console.log(result);
      })

      this.tweets.push(post_text)
      this.text = this.input.value = ''
    }
  }
</tweet>
