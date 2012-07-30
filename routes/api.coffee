mongoose = require 'mongoose'
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

# Comment Schema
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

# Post Schema
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
  Post.find {}, (err, posts) ->
    res.json posts: posts


exports.post = (req, res) ->
  Post.findById req.params.id, (err, post) ->
    res.json post: post

exports.addComment = (req, res) ->
  Post.findById req.params.id, (err, post) ->
    if !err
      comment = new Comment();
      comment.name = req.body.comment.name
      comment.text = req.body.comment.text
      post.comments.push comment

      post.save (err1) ->
        res.json post: post

exports.deleteComment = (req, res) ->
  cid = req.params.cid;
  Post.findById req.params.id, (err, post) ->
    if !err
      post.comments.id(cid).remove()
      post.save (err1) ->
        res.json post: post

exports.editComment = (req, res) ->
  cid = req.params.cid;
  Post.findById req.params.id, (err, post) ->
    if !err
      comment = post.comments.id(cid)
      # for c in req.body.comments
      #   do (c) ->
      #     if c._id = cid
      #     	comment.text = c.text
      comment.text = req.body.text
      post.save (err1) ->
        res.json post: post

exports.addPost = (req, res) ->
  post = new Post(req.body)
  post.save (err) ->
    res.json post: post


exports.editPost = (req, res) ->
  Post.findById req.params.id, (err, post) ->
    if !err
      post.title = req.body.title
      post.content = req.body.content
      post.save (err1) ->
        res.json post: post

exports.deletePost = (req, res) ->
  id = req.params.id
  Post.remove {_id: id}, (err) ->
    unless err
      res.json true
    else
      res.json false
