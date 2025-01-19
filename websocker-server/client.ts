import 'dotenv/config'
import WebSocket from 'ws';

const token = "" // Input your token here


const port: number = Number(process.env.PORT || 8080)

const ws = new WebSocket(`ws://localhost:${port}/`, {
  headers: {
    "x-session-token": token
  }
});
ws.on('error', console.error);

ws.on('open', function open() {
  
});

ws.on('message', function message(data) {
  console.log('received: %s', data);
});

