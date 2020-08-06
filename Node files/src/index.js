const express = require('express')                     // To import the settings related to server
require('./db/mongoose')                               // To setup database
const userRouter = require('./routers/user')           // Providing various paths/routes/URL to the user
const visitRouter = require('./routers/visit')           // Providing various paths/routes/URL to the user
const bookmarkRouter = require('./routers/bookmark')           // Providing various paths/routes/URL to the user

const app = express()                                  // Syntax
const port = process.env.PORT || 3000                  // To set port to localhost or given port(after deployment)

app.use(express.json())                                // Method of express to recognise incoming request as JSON Object
app.use(userRouter)                                    // Instructing to use other routes
app.use(visitRouter)                                    // Instructing to use other routes
app.use(bookmarkRouter)                                    // Instructing to use other routes

app.listen(port, () => {                               // To run server
    console.log('Server is up on port ' + port)
})  