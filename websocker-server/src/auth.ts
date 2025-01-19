import { IncomingMessage } from "http";
import { JwtPayload, verify } from "jsonwebtoken"

export function authenticateToken(request: IncomingMessage, successCb: () => void, cb: (err: Error) => void) {
  try {
    const token = request.headers["x-session-token"] as string;
    const decode = verify(token, process.env["SERVER_APP_SECRET"] || "") as JwtPayload;
    if (!decode["session_id"]) {
      cb(new Error("Error decoding token"))
      return;
    } 
    successCb()
  }
  catch(err: any) {
    cb(new Error(err.message))
  }
}