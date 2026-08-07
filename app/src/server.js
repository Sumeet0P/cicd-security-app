require('dotenv').config();
const app = require('./app');

const PORT = process.env.PORT || 3000;

require('./config/db');

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});