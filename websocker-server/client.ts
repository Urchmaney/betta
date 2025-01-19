import WebSocket from 'ws';

const token = "eyJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uX2lkIjoxMH0.d5uydI_CeMGbRuAtYUlGfZgKXx6_x13X2W5JKbxVUU0" // change token to your own 
const ws = new WebSocket('ws://localhost:8080/', {
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

