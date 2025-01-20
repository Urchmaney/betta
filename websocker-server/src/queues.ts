import logger from "./logger";
import { redisInstance } from "./redis";
import { v4 as uuidv4 } from 'uuid';

function addToQueue(queue: string, worker: string, args: (string | number)[]) {
  try {
    const redis = redisInstance();
    const fullQueue = `queue:${queue}`;
    redis.lpush(`queue:${queue}`, JSON.stringify({
      job_id: uuidv4(),
      class: worker,
      args: args,
      queue: fullQueue
    }))
    logger.info(`Job for worker: ${worker} has been queued with arguments ${args}`);
  } catch(e) {
    logger.error(`Error: Queuing Job for worker: ${worker} with arguments ${args}: ${(e as Error).message}`)
  }
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

function queueUpdateOddEvent(args: (string | number)[], queue: string = "default") {
  addToQueue(queue, "UpdateOddWorker", args);
}

const queueRegistry: Record<string, (args: (string | number)[], queue?: string) => void> = {
  "newGames": addNewGamesJob,
  "newUsers": addNewUsersJob,
  "newBets": addNewBetsJob,
  "newGameEvent": queueNewGameEvent,
  "oddUpdateEvent": queueUpdateOddEvent
}

export default queueRegistry