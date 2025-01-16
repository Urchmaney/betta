// import { createClient } from 'redis';

// const client = createClient()
// .on('error', err => console.log('Redis Client Error1', err))
// .connect().then((client: ReturnType<typeof createClient>) => {
//   client.publish("leaderboard changes", "FROM publisher")
// });

export function redisConnection (): { host? : string, port?: number } {
  if (!process.env.REDIS_HOST) {
    return {}
  }

  return {
    host: process.env.REDIS_HOST,
    port: Number(process.env.REDIS_PORT || 6379)
  }
}