import IORedis from "ioredis";
import { Queue } from 'bullmq';

const GAME_QUEUE = "game_queue"

const connection = new IORedis({ maxRetriesPerRequest: null, db: 0, host: "127.0.0.1", port: 6379 })

const gameQueue = new Queue(GAME_QUEUE, { connection })

export function addMessageToGameQueue(message: unknown) {
    gameQueue.add("save", JSON.stringify(message))
}