express = require 'express'
stylus = require 'stylus'
# bootstrap = require 'bootstrap-stylus'
assets = require 'connect-assets'

routes = require './routes'
api = require './routes/api'
mongoose = require 'mongoose'
db = null
app = express()

# Add Connect Assets
app.use assets()
# Set View Engine
app.set 'view engine', 'jade'


# Configure
app.configure "development", ->
  app.use express.bodyParser()
  app.use express.methodOverride()
  # app.use(express.compiler({ src : __dirname + '/public', enable: ['less']}));  
  app.use express.static(__dirname + '/public')
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  db = mongoose.connect 'mongodb://alder:123456@ds035037.mongolab.com:35037/angular-blog'

app.configure "production", ->
  app.use express.errorHandler()
  db = mongoose.connect 'mongodb://alder:123456@ds035037.mongolab.com:35037/angular-blog'



 # Routes
app.get '/', routes.index 
app.get '/partials/:name', routes.partials 

# JSON API
app.get '/api/posts', api.posts 

app.get '/api/post/:id', api.post 
app.post '/api/post', api.addPost 
app.post '/api/post/:id/newComment', api.addComment 
app.delete '/api/post/:id/deleteComment/:cid', api.deleteComment 
app.put '/api/post/:id/editComment/:cid', api.editComment 
app.put '/api/post/:id', api.editPost 
app.delete '/api/post/:id', api.deletePost 

# redirect all others to the index (HTML5 history)
# app.get '*',  (req, res) ->
#   res.render "index"

# Define Port
port = process.env.PORT or process.env.VMC_APP_PORT or 3000
# Start Server
app.listen port, -> console.log "Listening on #{port}\nPress CTRL-C to stop server."