import 'dotenv/config'
import { LeaderboardSubscription } from './src/leaderboard.subscription';
import { createSocketServer } from './src/socket';
import { registerSubscriptionChannels } from './src/subscribers';
import { createHTTPServer } from './src/server';

const wss = createSocketServer()
const server = createHTTPServer(wss);
registerSubscriptionChannels(wss);


