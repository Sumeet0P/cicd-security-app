const express = require('express');
const app = express();

const API_KEY = process.env.API_KEY;

app.get('/', (req, res) => {
  res.send('Hello from cicd-security project 🚀');
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Server running on port 3000');
});