express = require 'express'
http = require 'http'
path = require 'path'
# less = require 'less'

stylus = require 'stylus'
assets = require 'connect-assets'

routes = require './routes'
api = require './routes/api'
mongoose = require 'mongoose'

db = null
app = express()

app.use assets()

app.configure ->
  app.set 'port', process.env.PORT or 3000
  app.set 'views', __dirname + '/views'
  app.set 'view engine', 'jade'
  app.use express.favicon()
  app.use express.logger('dev')
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser('652626bvhfdhghy52h5g')
  app.use express.session()
  app.use app.router
  # app.use require('less-middleware')(src: __dirname + '/assets')
  app.use express.static(path.join(__dirname, 'public'))


app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )
  db = mongoose.connect 'mongodb://user:user@ds035037.mongolab.com:35037/angular-blog'

app.configure "production", ->
  app.use express.errorHandler()
  db = mongoose.connect 'mongodb://user:user@ds035037.mongolab.com:35037/angular-blog'



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
app.get '*',  (req, res) ->
  res.render "index"

http.createServer(app).listen app.get('port'), ->
  console.log 'Express server listening on port ' + app.get('port')
