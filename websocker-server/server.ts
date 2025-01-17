import 'dotenv/config'
import { Redis } from "ioredis";
import { LeaderboardSubscription } from './src/leaderboard.subscription';
import { redisConnection } from './src/redis';
import { createSocketServer } from './src/socket';

const port: number = Number(process.env.PORT || 8080)

const wss = createSocketServer(port)

const redis: Redis = new Redis(redisConnection())

new LeaderboardSubscription(redis, wss);

console.log(`Listening at port ${port}`)