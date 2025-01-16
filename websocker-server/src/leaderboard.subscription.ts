import { Redis } from "ioredis";
import type WebSocket from 'ws';

export class LeaderboardSubscription {
  private readonly channelsMap: Record<string, (message: string) => void> = {
    "leaderboard changes": this.broadcastLeaderboardChange
  }


  constructor(redis: Redis, private wss: WebSocket.Server) {
    redis.subscribe(...Object.keys(this.channelsMap), (err, count) => {  if (err) throw err; })
    redis.on("message", (channel, message) => {
      if (this.channelsMap[channel]) {
        this.channelsMap[channel] = this.channelsMap[channel].bind(this)
        this.channelsMap[channel](message)
      }
    })
  }

  broadcastLeaderboardChange(message: string | Buffer) {
    this.wss.clients.forEach((ws) => {
      ws.send(message)
    })
  }
}
