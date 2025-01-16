import { Queue, Worker } from 'bullmq';
import IORedis from "ioredis";
import { redisConnection } from '../redis';

export const GAME_QUEUE = "game_queue_cube"

const connection = new IORedis({ maxRetriesPerRequest: null, db: 0, host: "127.0.0.1", port: 6379 })

// const que = new Queue("GAME_QUEUE", { connection })
// que.add("mnl", { test: "now"})
// que.getDelayedCount().then(x=> console.log(x, "==="));
// console.log(que.getDelayedCount)

connection.lrange("queue:game_queue_cube", 0, 1).then(x => console.log(x));

export const gameWorker = new Worker(
  GAME_QUEUE,
  async job => {
    // Will print { foo: 'bar'} for the first job
    // and { qux: 'baz' } for the second.
    
  },
  { connection },
);


gameWorker.on("active", () => console.log("active"))