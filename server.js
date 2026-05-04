const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

// 정적 파일 제공 (이미지)
app.use('/images', express.static(path.join(__dirname, 'images')));

// 더미 데이터 로드
const destinations = require('./destinations.json');
const products = require('./products.json');

// 전체 목록 API
app.get('/destinations', (req, res) => {
  res.json(destinations);
});

// 단건 조회 API
app.get('/destinations/:id', (req, res) => {
  const destination = destinations.find(d => d.id === parseInt(req.params.id));
  if (!destination) {
    return res.status(404).json({ message: 'Not found' });
  }
  res.json(destination);
});

// 여행 상품 목록 API
// GET /destinations/:id/products
app.get('/destinations/:id/products', (req, res) => {
  const id = req.params.id;
  const destinationProducts = products[id];
  if (!destinationProducts) {
    return res.status(404).json({ message: 'Not found' });
  }
  res.json(destinationProducts);
});

app.listen(PORT, () => {
  console.log(`서버 실행 중: http://localhost:${PORT}`);
});
