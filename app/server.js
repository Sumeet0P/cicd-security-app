const express = require('express');
const app = express();

const API_KEY = "sk_test_123456789SECRETKEY";

app.get('/', (req, res) => {
  res.send('DevOps Project Running 🚀');
});

app.listen(3000, '0.0.0.0', () => {
  console.log('Server running on port 3000');
});