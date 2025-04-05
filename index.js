// index.js
const express = require('express');
const app = express();

// Use environment variable or default to 3000
const port = process.env.PORT || 3000;

// Basic Route
app.get('/', (req, res) => {
  res.send('Hello from Docker container!');
});

// JSON Response Route
app.get('/status', (req, res) => {
  res.json({
    message: 'Dockerized Express app is running!',
    status: 'success',
    timestamp: new Date().toISOString(),
  });
});

// Error handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    error: 'Something went wrong!',
    message: err.message,
  });
});

// Start the server
app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
