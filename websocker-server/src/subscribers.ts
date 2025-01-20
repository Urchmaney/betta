
import WebSocket from 'ws';
import { redisInstance } from './redis';

const subscribedChannels: Record<string, (wss: WebSocket.WebSocketServer, message: string) => void> = {
  "cashback_update": publishCashback,
  "new_win": publishNewWin,
  "total_win": publishTotalWins
}

export function registerSubscriptionChannels(wss: WebSocket.WebSocketServer) {
  const redis = redisInstance();
  redis.subscribe(...Object.keys(subscribedChannels), (err?: Error | null, result?: unknown) => {
    if(err) throw err
  });

  redis.on("message", (channel, message) => {
    subscribedChannels[channel](wss, message)
  })
}

function publishMessage(wss: WebSocket.WebSocketServer, message: string) {
  wss.clients.forEach((client: WebSocket) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(message));
    }
  });
}

function publishNewWin(wss: WebSocket.WebSocketServer, message: string) {
  publishMessage(wss, JSON.stringify({ type: "newWin", data: JSON.parse(message) }));
}

function publishCashback(wss: WebSocket.WebSocketServer, message: string) {
  publishMessage(wss, JSON.stringify({ type: "cashback", data: JSON.parse(message) }));
}

function publishTotalWins(wss: WebSocket.WebSocketServer, message: string) {
  publishMessage(wss, JSON.stringify({ type: "totalWins", data: JSON.parse(message) }));
}