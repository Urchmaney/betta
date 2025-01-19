import { redisInstance } from "./redis";
import { v4 as uuidv4 } from 'uuid';

function addToQueue(queue: string, worker: string, args: (string | number)[]) {
  const redis = redisInstance();
  const fullQueue = `queue:${queue}`; 
  redis.lpush(`queue:${queue}`, JSON.stringify({
    job_id: uuidv4(),
    class: worker,
    args: args,
    queue: fullQueue
  }))
}

function queueNewGameEvent(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "LiveEventWorker", args)
}

function addNewGamesJob(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "AddGamesWorker", args);
}

function addNewUsersJob(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "AddUsersWorker", args);
}

function addNewBetsJob(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "AddBetsWorker", args);
}

const queueRegistry: Record<string, (args: (string | number)[], queue?: string) => void> = {
  "newGames": addNewGamesJob,
  "newUsers": addNewUsersJob,
  "newBets": addNewBetsJob,
  "newGameEvent": queueNewGameEvent,
}

export default queueRegistry