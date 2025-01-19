# Websocket Server (Node js / WS)
This is the websocket server that communicates with the clients in realtime.
It uses
- Ws (Websocket Server)
- Redis (Async Communication)


## Setup
- Run `npm install` to install all dependencies
- Then, we setup our environment variable. there is a file `.env.example` in the folder you can use as a sample or copy from the code below.
```
SERVER_APP_SECRET = ...
REDIS_HOST = ...
REDIS_PORT = ...
```
The `SERVER_APP_SECRET` configuration should be the same as the `APP_SECRET` configuration in the main server app. And since both application uses the same redis server for communcation make sure they are same. Like in the server side if you are using a local redis server, the configuration can be ommited.
- To start our application, run `npm run start`