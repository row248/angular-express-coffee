mongoose = require("mongoose")
Schema = mongoose.Schema
ObjectId = Schema.ObjectId

Article = new Schema(
  title:
    type: String
    index:
      unique: true
  data: String
  tags: [ String ]
  user_id: ObjectId
)
mongoose.model "Article", Article
exports.Article = (db) ->
  db.model "Article"