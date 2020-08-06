const mongoose = require('mongoose')

const visitSchema = new mongoose.Schema({
    visits: {
        type: String,
        required: true,
        trim: true
    },
    completed: {
        type: Boolean,
        default: false
    },
    owner: {
        type: mongoose.Schema.Types.ObjectId,
        required: true,
        ref: 'User'
    }
}, {
    timestamps: true
})
 
const Visit = mongoose.model('Visit', visitSchema)

module.exports = Visit