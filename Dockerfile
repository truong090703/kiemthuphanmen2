# Sử dụng Node.js làm base image
FROM node:18

# Thiết lập thư mục làm việc
WORKDIR /app

# Copy file package.json và package-lock.json
COPY package*.json ./

# Cài đặt các dependencies
RUN npm install

# Copy toàn bộ mã nguồn vào container
COPY . .

# Build ứng dụng React
RUN npm run build

# Sử dụng Nginx để phục vụ ứng dụng React
FROM nginx:stable-alpine
COPY --from=0 /app/build /usr/share/nginx/html

# Expose port của frontend (ví dụ: 3000)
EXPOSE 3000

# Chạy Nginx
CMD ["nginx", "-g", "daemon off;"]
