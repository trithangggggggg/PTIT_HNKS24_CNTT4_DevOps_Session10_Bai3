const express = require('express');
const cors = require('cors');

const app = express();
const PORT = process.env.PORT || 3000;

app.use(cors());
app.use(express.json());

app.get('/', (req, res) => {
  res.json({
    status: 'success',
    message: 'DevOps Session 10 - Exercise 3 Backend API is running smoothly!',
    architecture: 'Docker Multi-stage Build & Layer Caching Demo',
    timestamp: new Date().toISOString()
  });
});

app.get('/api/health', (req, res) => {
  res.json({
    uptime: process.uptime(),
    status: 'OK',
    memoryUsage: process.memoryUsage(),
    timestamp: Date.now()
  });
});

app.listen(PORT, '0.0.0.0', () => {
  console.log(`Server listening on port ${PORT}`);
});
