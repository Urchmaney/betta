
import WebSocket from 'ws';
import { redisInstance } from './redis';

const subscribedChannels: Record<string, (wss: WebSocket.WebSocketServer, message: string) => void> = {
  "new_winners_total_amount": newWinnerTotalAmount
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

function newWinnerTotalAmount(wss: WebSocket.WebSocketServer, message: string) {
  wss.clients.forEach((client: WebSocket) => {
    if (client.readyState === WebSocket.OPEN) {
      client.send(JSON.stringify(message));
    }
  })    
}
