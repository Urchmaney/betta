import Redis from "ioredis";

export function redisInstance() {
  return new Redis({
    host: process.env.REDIS_HOST,
    port: process.env.REDIS_PORT ? Number(process.env.REDIS_PORT) : undefined
  })
}
export const redis: Redis = redisInstance();