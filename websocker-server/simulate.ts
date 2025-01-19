import 'dotenv/config'
import WebSocket from 'ws';

const token = "" // Input your token here
const port: number = Number(process.env.PORT || 8080)
const ws = new WebSocket(`ws://localhost:${port}/`, {
  headers: {
    "x-session-token": token
  }
});
const events = [
  {
    type: "newGameEvent",
    data: [{
      gameId: "G1",
      events: [
        { type: "yellowCard", team: "home", player: "Player 2", minute: 70 },
      ]
    }]
  },
  {
    type: "newGameEvent",
    data: [{
      gameId: "G2",
      homeScore: 1,
      awayScore: 0,
      events: [
        { type: "goal", team: "home", player: "Player 5", minute: 30 },
      ]
    }]
  },
  {
    type: "newGameEvent",
    data: [{
      gameId: "G2",
      events: [
        { type: "redCard", team: "away", player: "Player 7", minute: 40 },
      ]
    }]
  },
  {
    type: "newGameEvent",
    data: [{
      gameId: "G2",
      events: [
        { type: "fullTime", team: "home", player: "", minute: 95 }
      ]
    }]
  }
]
ws.on('error', console.error);

ws.on('open', function open() {
  const randomNumberInEvents = Math.floor(Math.random() * ((events.length -1) + 1) + 0);
  console.log(`Sent Event Number - ${randomNumberInEvents}`)
  ws.send(JSON.stringify(events[randomNumberInEvents]));
  ws.close();
});
