# DevOps Fundamental - Session 10 - Bài tập 3

Dự án triển khai và tối ưu hóa Docker Image cho ứng dụng Node.js/Express sử dụng kỹ thuật **Multi-stage build** kết hợp **Docker Layer Caching**.

---

## 1. Cấu trúc thư mục

```
bai3/
├── .dockerignore        # Bỏ qua node_modules, log, file không cần thiết khi build
├── Dockerfile           # Multi-stage build (tối ưu hóa kích thước image và bảo mật)
├── Dockerfile.single    # Single-stage build (dùng để đo lường và so sánh)
├── package.json         # Danh sách dependencies (Express, CORS, Dotenv)
├── server.js            # Node.js Express server
└── README.md            # Tài liệu hướng dẫn và báo cáo
```

---

## 2. Các tính năng & Tối ưu hóa

- **Multi-stage Build**: Tách riêng giai đoạn cài đặt dependencies (`builder`) và runtime production (`runner`), giúp loại bỏ các công cụ build thừa và giảm thiểu dung lượng image.
- **Docker Layer Caching**: Tách riêng thao tác `COPY package*.json ./` và `RUN npm install` trước khi copy source code để tận dụng cache layer khi chỉ sửa source code.
- **Bảo mật**: Sử dụng base image nhẹ (`node:18-alpine`), loại bỏ rủi ro bảo mật từ các package dev.

---

## 3. Hướng dẫn chạy thử nghiệm

### 3.1. Chạy trực tiếp với Node.js
```bash
npm install
npm start
```

### 3.2. Build & Chạy với Docker (Multi-stage)
```bash
# Build image
docker build -t devops-session10-bai3:latest .

# Run container
docker run -d -p 3000:3000 --name devops-bai3 devops-session10-bai3:latest

# Kiểm tra API
curl http://localhost:3000/
curl http://localhost:3000/api/health
```

### 3.3. So sánh kích thước giữa Single-stage và Multi-stage
```bash
docker build -f Dockerfile.single -t devops-session10-bai3:single .
docker images | grep devops-session10-bai3
```
