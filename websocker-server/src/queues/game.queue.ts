import IORedis from "ioredis";
import { Queue } from 'bullmq';
import { v4 as uuidv4 } from 'uuid';

const connection = new IORedis({ maxRetriesPerRequest: null,
  db: Number(process.env.REDIS_DB || 0),
  host: process.env.REDIS_HOST || "localhost",
  port: Number(process.env.REDIS_DB || 6379),
})

const gameQueue = new Queue("default", { connection })

export function addMessageToGameQueue(message: Buffer | ArrayBuffer | Buffer[]) {
  const sideKiqObj = {
    class: 'AddGamesWorker',
    args: [message.toString()],
    queue: 'default',
    retry: true,
    jid: uuidv4(),
  }
  gameQueue.add("save", JSON.stringify(sideKiqObj))
}