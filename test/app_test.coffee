request = require 'request'
api = require '.././routes/api'
mongoose = require 'mongoose'
mongoose.connect 'mongodb://user:user@ds035037.mongolab.com:35037/angular-blog'
Post = api.Post


Browser = require "zombie"

browser = new Browser()


describe "Given I am a new user", ->
  describe "When I visit the home page", ->
    before (done) ->
      browser.visit "http://localhost:3000/", ->
        browser.success.should.be.true
        browser.errors.should.not.exist
        done()

    it "Then I should see 'Angular Blog'", ->
      browser.html().should.match /Angular Blog/

    it "And I should see all posts", ->
      browser.html().should.match /Sed eros est, sagittis at commodo/

    describe 'When I click new post', ->
      browser.clickLink "#new-post", ->
        _browser.location.pathname.should.equal 'http://localhost:3000/newPost'



# describe 'Posts', ->
#   response = null
#   before (done) ->
#     post = new Post()
#     post.title = 'Title'
#     post.content = 'Content'
#     post.save()
#     done()

#   it 'should get all posts', (done) ->
#     request 'http://localhost:3000/posts.json', (e, r, b) ->
#       response = r
#       done()
  
#   it 'should return 200', (done) ->
#     response.statusCode.should.equal 200
#     done()



  # it 'should get saved Post', (done) ->
  #   request().post('/posts').set('Content-Type','application/json').expect(200,done)

# describe 'Sample test', ->
#   it 'should be true', ->
#     true.should.equal true

# describe 'GET /', ->
#   response = null
#   before (done) ->
#     request 'http://localhost:3000', (e, r, b) ->
#       response = r
#       done()

#   it 'should return 200', (done) ->
#     response.statusCode.should.equal 200
#     done()

  # it 'should show all posts', (done) ->
