
import { AxiosResponse } from 'axios';
import WebSocket, { WebSocketServer } from 'ws';
import { fetchLeaderboard } from './api';
import { addNewBetsJob, addNewGamesJob, addNewUsersJob } from './redis';

const jobMap: Record<string, (args: (string | number)[], queue?: string) => void> = {
  "newGames": addNewGamesJob,
  "newUsers": addNewUsersJob,
  "newBets": addNewBetsJob
}

export function createSocketServer () : WebSocket.WebSocketServer{
  const wss: WebSocket.Server = new WebSocketServer({ noServer: true });

  
  wss.on("connection", (ws: WebSocket) => {
    // fetchLeaderboard().then((response: AxiosResponse) => {
    //   ws.send(response.data as string)
    // });

    ws.on("message", (message: WebSocket.RawData) => {
      const messageObj = JSON.parse(message.toString());
      jobMap[messageObj.type]([messageObj.data])
    })
  });
  
  return wss;
}