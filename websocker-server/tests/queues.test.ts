import queryRegister from "../src/queues";
import { describe, expect, test, jest } from '@jest/globals';
import { redisInstance } from "../src/redis";
import logger from "../src/logger";


beforeAll(done => {
  done()
})


afterAll(done => {
  done()
})

let result: { queue: string, data: string }[] = [];

jest.mock('../src/redis', () => {
  return {
    redisInstance: jest.fn(() => ({
      lpush: (queue: string, data: string) => {
        result.push({ queue, data })
      }
    })),
  }
});

jest.mock('../src/logger', () => {
  return {
    info: jest.fn((_) => { }),
  }
});

describe("Queue Module", () => {
  test("newGame Event Queue to LiveEventWorker worker", () => {
    const eventType = "newGameEvent";
    result = [];
    const args = ["slow"];
    queryRegister?.[eventType](args);

    expect((redisInstance as jest.MockedFunction<typeof redisInstance>).mock.calls).toHaveLength(1);
    expect((logger.info as jest.MockedFunction<typeof logger.info>).mock.calls).toHaveLength(1);
    expect(result.length).toBe(1);
    expect(JSON.parse(result[0].data)["class"]).toBe("LiveEventWorker");
    expect(JSON.parse(result[0].data)["args"][0]).toBe("slow")

  })
})