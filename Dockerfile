#####################################################
# Multi Step Build File for Production Environment
#####################################################

# Phase 1: (Build Step)
# 1) Use node:alpine
# 2) Copy the package.json file
# 3) Install dependencies
# 4) Run 'npm run build'
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Phase 2: (Run Step)
# 1) User nginx
# 2) Copy result of 'npm run build'
# 3) Start nginx (default command starts it)
FROM nginx
# Elasticbeanstalk use Expose command to automatically do the port mapping
EXPOSE 80 
COPY --from=builder /app/build /usr/share/nginx/html

