<contact>
  <h3>{ message }</h3>
  <ul>
    <li each={ contacts }>
      <div class="panel panel-default">
        <div class="panel-body">
          <p>Name: { name }</p>
          <p>Phone: { phone }</p>
          <p>Facility: { facility }</p>
        </div>
      </div>
    </li>
  </ul>

  <script>
    this.message = 'Contacts'
    this.contacts = opts.contacts // you can get opts from the mount() function
  </script>

  <style scoped>
    :scope { font-size: 2rem }
    h3 { color: #444 }
    ul { font-size: 1rem }
    li { list-style-type: none }
  </style>
</contact>
