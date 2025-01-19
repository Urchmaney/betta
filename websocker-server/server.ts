import 'dotenv/config'
import { LeaderboardSubscription } from './src/leaderboard.subscription';

import { createSocketServer } from './src/socket';
import { createServer, IncomingMessage } from 'http';
import { Duplex } from 'stream';
import { redis } from "./src/redis";
import { authenticateToken } from './src/auth';
import { registerSubscriptionChannels } from './src/subscribers';

const wss = createSocketServer()
const server = createServer();

server.on("upgrade", function (request: IncomingMessage, socket: Duplex, head: Buffer) {
  authenticateToken(request,
    () => { 
      wss.handleUpgrade(request, socket, head, function done(ws) {
        wss.emit('connection', ws, request);
      });
    },
    (err) => {
      socket.write('HTTP/1.1 401 Unauthorized\r\n\r\n');
      socket.destroy();
      return;
    })
})

const port: number = Number(process.env.PORT || 8080)

registerSubscriptionChannels(wss);

new LeaderboardSubscription(redis, wss);

server.listen(port)

console.log(`Listening at port ${port}`)