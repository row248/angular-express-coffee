request = require 'request'
api = require '.././routes/api'
mongoose = require 'mongoose'
mongoose.connect 'mongodb://alder:datura@ds035037.mongolab.com:35037/angular-blog-test'
Post = api.Post

describe 'Posts', ->
  response = null
  before (done) ->
    post = new Post()
    post.title = 'Title'
    post.content = 'Content'
    post.save()
    done()

  it 'should get all posts', (done) ->
    request 'http://localhost:3000/posts.json', (e, r, b) ->
      response = r
      done()
  
  it 'should return 200', (done) ->
    response.statusCode.should.equal 200
    done()

  if 'should get saved Post', (done) ->
    request().post('/posts').set('Content-Type','application/json').expect(200,done)

describe 'Sample test', ->
  it 'should be true', ->
    true.should.equal true

describe 'GET /', ->
  response = null
  before (done) ->
    request 'http://localhost:3000', (e, r, b) ->
      response = r
      done()

  it 'should return 200', (done) ->
    response.statusCode.should.equal 200
    done()

  # it 'should show all posts', (done) ->
