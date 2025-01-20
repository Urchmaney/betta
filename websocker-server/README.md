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
PORT = ...
```
The `SERVER_APP_SECRET` configuration should be the same as the `APP_SECRET` configuration in the main server app. And since both application uses the same redis server for communcation make sure they are same. Like in the server side if you are using a local redis server, the configuration can be ommited.
- To start our application, run `npm run start`

### Starting Client and Simulator
With the websocket server up and running, we need something to connect to the websocket and simulate send live updates.<br>
Before we can use these tools, we need to get `token` for authentication. [Follow these instructions to get them.](../server/README.md#getting-authentication-token)<br>

Now you have the `token`, Open the following files `/betta/websocker-server/client.ts`, `/betta/websocker-server/simulate.ts` and replace the tokens.

- The Client:- This stands in place to recieve any updates, Like leaderboard changes, odds updates and so on. we startup the client with the following command
```
export PORT={port} && npm run start:client
```
The `{port}` is a place holder for the port the websocket server is listening on.
N:B This command assumes you are in the `websocker-serve` working directory.
Now the client is now listening for updates.

- The Simulator:- This help us simulates sending live updates to our application. It has a set of events and randomly pick one as event to send. Not the most sophisticated.
Each time we want to send update, we run this command
```
export PORT={port} && npm run simulate
```
The same conditions follow as the ones above.