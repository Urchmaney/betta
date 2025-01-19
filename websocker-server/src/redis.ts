import Redis from "ioredis";
import { v4 as uuidv4 } from 'uuid';

function redisInstance() {
  return new Redis({
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT ? Number(process.env.REDIS_PORT) : undefined
  })
}
export const redis: Redis = redisInstance();

export function addToQueue(queue: string, worker: string, args: (string | number)[]) {
  const redis = redisInstance();
  const fullQueue = `queue:${queue}`; 
  redis.lpush(`queue:${queue}`, JSON.stringify({
    job_id: uuidv4(),
    class: worker,
    args: args,
    queue: fullQueue
  }))
}

export function addNewGamesJob(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "AddGamesWorker", args);
}

export function addNewUsersJob(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "AddUsersWorker", args);
}

export function addNewBetsJob(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "AddBetsWorker", args);
}