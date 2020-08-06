const mongoose = require('mongoose')

const bookmarkSchema = new mongoose.Schema({
    userBookmark: {
        type: String,
        required: true,
        trim: true
    },
    location: {
        type: String,
        required: true,
        trim: true
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'User'
    }
}, {
    timestamps: true
})
 
const Bookmark = mongoose.model('Bookmark', bookmarkSchema)

module.exports = Bookmark