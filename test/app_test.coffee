request = require 'request'
api = require '.././routes/api'
# mongoose = require 'mongoose'
# mongoose.connect 'mongodb://user:user@ds037007.mongolab.com:37007/angular-blog-test'
Post = api.Post

Browser = require "zombie"

browser = new Browser({debug: true})

describe "Given I am a new user", ->
  describe "When I visit the home page", ->
    before (done) ->
      browser.visit "http://localhost:3000/", ->
        done()
        # Post.remove()
        # post1 = new Post()
        # post1.title = "First post"
        # post1.content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit."
        # post1.save (err) ->
          # err.should.be.empty
          # done()
        # post2 = new Post({title: "Second post", content: "Vestibulum congue risus non risus lobortis vulputate."})
        # post2.save (err) ->
          # err.should.be.empty
          # done err

    it "Then browser status should be ok", ->
      browser.success.should.be.true
      browser.errors.should.be.empty


    it 'Then I shouldn\'t see any Posts', ->
      # browser.html().should.not.match /First post/
      browser.html().should.not.match /Second post/
      browser.html().should.not.match /Third post/

    it "Then I should see h1 'Angular Blog'", ->
      browser.text("h1").should.equal 'Angular Blog'
    
    it 'Then I should see new post link'  , ->
      browser.text("#new-post").should.equal 'New post'

    describe 'When I click new post', ->
      it 'Then I shold see new post form', (done) ->
        browser.visit 'http://localhost:3000/newPost', ->
        # browser.clickLink "New post", (done) ->
          # browser.query('legend').should.equal /Write a new post/
          # browser.window.location.pathname.should.equal 'http://localhost:3000/newPost'
          done()

      it 'Then i should see new post form', ->
        browser.text('legend').should.equal 'Write a new post'
      
      describe 'When I fill data', ->
        before (done) ->
          browser.fill "title", "First post"
          browser.fill "content", "gfdfgsdfgds"
          browser.pressButton "Save", ->
            done()

        # it 'Then I shold see new post form', ->
        #   browser.html().should.match /First post/
    # describe 'When I visit new post page', ->
    #   it 'Should have post form', (done) ->
    #     browser.visit 'http://localhost:3000/newPost', ->
    #       browser.text("legend").should.equal 'Write a new post'
    #       done()