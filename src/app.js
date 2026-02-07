const express = require('express');
const app = express();

app.use(express.json());

// ✅ ROUTE ROOT
app.get('/', (req, res) => {
  res.send('Edu Course API is running 🚀');
});

// routes lain
const courseRoute = require('./routes/course.route');
app.use('/api/courses', courseRoute);

module.exports = app;
