mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

CommentSchema = new Schema(
  name:
    type: String
    # required: true
  text: String
    # required: true
  created:
    type: Date
    default: Date.now
)

PostSchema = new Schema(
  title:
    type: String
    # required: true
    index:
      unique: true
  content: String
    # required: true
  created:
    type: Date
    default: Date.now
  comments : [CommentSchema]
)

mongoose.model "Comment", CommentSchema
Comment = mongoose.model "Comment"

mongoose.model "Post", PostSchema
Post = mongoose.model "Post"


exports.posts = (req, res) ->
  posts = []
  Post.find {}, (err, docs) ->
    unless err
      # console.log docs.first()
      posts = docs
      # console.log posts
      # process.exit()
    else
      throw err
    # console.log posts
    res.json posts: posts


exports.post = (req, res) ->
  id = req.params.id;
  Post.findById id, (err, post) ->
    unless err
      # console.log post
    else
      throw err
      console.log err
    res.json post: post

exports.addComment = (req, res) ->
  id = req.params.id;
  console.log req.body
  Post.findById id, (err, post) ->
    unless err
      console.log post
      comment = new Comment();
      comment.name = req.body.comment.name
      comment.text = req.body.comment.text
      post.comments.push comment
      post.save (err1) ->
        unless err1
          console.log post
        else
          throw err1
          console.log err1
        # console.log posts
        res.json post: post
    else
      throw err
      console.log err

exports.deleteComment = (req, res) ->
  id = req.params.id;
  cid = req.params.cid;
  console.log cid
  Post.findById id, (err, post) ->
    unless err
      post.comments.id(cid).remove()
      post.save (err1) ->
        unless err1
          console.log post
        else
          throw err1
          console.log err1
        res.json post: post
    else
      throw err
      console.log err

exports.editComment = (req, res) ->
  id = req.params.id;
  cid = req.params.cid;
  console.log cid
  Post.findById id, (err, post) ->
    unless err
      comment = post.comments.id(cid)
      # for c in req.body.comments
      #   do (c) ->
      #     if c._id = cid
      #     	comment.text = c.text
      console.log req.body.text
      comment.text = req.body.text
      post.save (err1) ->
        unless err1
          # console.log post
        else
          throw err1
          console.log err1
        res.json post: post
    else
      throw err
      console.log err


exports.addPost = (req, res) ->
  console.log req.body
  post = new Post(req.body)
  post.save (err) ->
    unless err
      console.log post
    else
      throw err
      console.log err
    # console.log posts
    res.json post: post


exports.editPost = (req, res) ->
  id = req.params.id
  Post.findById id, (err, post) ->
    unless err
      post.title = req.body.title
      post.content = req.body.content
      post.save (err1) ->
        unless err1
          console.log post
        else
          throw err1
          console.log err
        # console.log posts
        res.json post: post
    else
      throw err
      console.log err
    # console.log posts
    # res.json post: post


exports.deletePost = (req, res) ->
  id = req.params.id
  Post.remove {_id: id}, (err1) ->
    unless err1
      res.json true
    else
      res.json false
