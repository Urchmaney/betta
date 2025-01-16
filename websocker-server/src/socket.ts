
import { AxiosResponse } from 'axios';
import WebSocket, { WebSocketServer } from 'ws';
import { fetchLeaderboard } from './api';

export function createSocketServer (port: number) : WebSocket.WebSocketServer{
  const wss: WebSocket.Server = new WebSocketServer({ port });

  wss.on("connection", (ws: WebSocket) => {
    fetchLeaderboard().then((response: AxiosResponse) => {
      ws.send(response.data as string)
    })
  })
  
  return wss;
}