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
