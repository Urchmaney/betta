
import { AxiosResponse } from 'axios';
import WebSocket, { WebSocketServer } from 'ws';
import { fetchLeaderboard } from './api';
import queueRegistry from './queues';

export function createSocketServer () : WebSocket.WebSocketServer{
  const wss: WebSocket.Server = new WebSocketServer({ noServer: true });

  
  wss.on("connection", (ws: WebSocket) => {
    // fetchLeaderboard().then((response: AxiosResponse) => {
    //   ws.send(response.data as string)
    // });

    ws.on("message", (message: WebSocket.RawData) => {
      const messageObj = JSON.parse(message.toString());
      queueRegistry[messageObj.type]?.([JSON.stringify(messageObj.data)])
    })
  });
  
  return wss;
}