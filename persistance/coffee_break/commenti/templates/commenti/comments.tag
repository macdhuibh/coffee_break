{% load i18n %}

<comment-box>
    <h1>Join The Conversation</h1>

    <comment-list comments={ comments }></comment-list>
    <comment-form ></comment-form>


    this.comments = opts.comments
    console.log(this.comments);       

    add(comment){
      $.post('api/comment/', comment, function(result){
        console.log(result);
      })
      console.log(this.comments);       
      this.comments.push(comment)
      this.update()
    }
</comment-box>

<comment-list>
 <comment each={ opts.comments } name={ this.name } opinion={ this.opinion }><comment>
</comment-list>

<comment-form>
  <h4>Add Comment</h4>
  <form class="form" onsubmit={ add }>
    <input type="text" name="name" class="input" placeholder="Name..">
    <textarea class="textarea" name="opinion" rows="4" placeholder="Your opinion.."></textarea>
    <input type="submit" class="btn btn-secondary" value="Post" >
  </form>

  add(e){
    var comment = {
      name: this.name.value,
      opinion: this.opinion.value
    }

    this.parent.add(comment)
    e.target.reset()
  }
</comment-form>

<comment>
  <div class="comment">
   <h4>{ name }</h4>
   <p>{ opinion }</p>
  </div>
</comment>