FROM node:latest as build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

FROM node:latest

WORKDIR /app

RUN npm install -g serve

COPY --from=build /usr/src/app/build ./build

EXPOSE 3000

# Command to serve the React app
CMD ["serve", "-s", "build", "-l", "3000"]