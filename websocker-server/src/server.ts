import { IncomingMessage, Server, createServer } from "http";
import { Duplex } from "stream";
import type WebSocket from 'ws';
import { authenticateToken } from "./auth";

export function createHTTPServer(wss: WebSocket.WebSocketServer): Server {
  const server: Server = createServer();

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
  server.listen(port)
  console.log(`Listening at port ${port}`)
  return server;
}
