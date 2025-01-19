import WebSocket from 'ws';

const token = "eyJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uX2lkIjoxMH0.d5uydI_CeMGbRuAtYUlGfZgKXx6_x13X2W5JKbxVUU0" // change token to your own 
const ws = new WebSocket('ws://localhost:8080/', {
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
