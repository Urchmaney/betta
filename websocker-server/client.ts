import WebSocket from 'ws';

const token = "eyJhbGciOiJIUzI1NiJ9.eyJzZXNzaW9uX2lkIjoxMH0.d5uydI_CeMGbRuAtYUlGfZgKXx6_x13X2W5JKbxVUU0" // change token to your own 
const ws = new WebSocket('ws://localhost:8080/', {
  headers: {
    "x-session-token": token
  }
});
ws.on('error', console.error);

ws.on('open', function open() {
  ws.send(JSON.stringify({
    type: "newGames",
    data: liveGameData
  }));

  ws.send(
    JSON.stringify({
      type: "newUsers",
      data: users
    })
  )

  ws.send(
    JSON.stringify({
      type: "newBets",
      data: bets
    })
  )
});

ws.on('message', function message(data) {
  console.log('received: %s', data);
});

const liveGameData = [
    {
      gameId: "G1",
      homeTeam: "Team A",
      awayTeam: "Team B",
      homeScore: 2,
      awayScore: 1,
      timeElapsed: 65,
      events: [
        { type: "goal", team: "home", player: "Player 1", minute: 23 },
        { type: "goal", team: "away", player: "Player 5", minute: 41 },
        { type: "goal", team: "home", player: "Player 2", minute: 62 }
      ]
    },
    {
      gameId: "G2",
      homeTeam: "Team C",
      awayTeam: "Team D",
      homeScore: 0,
      awayScore: 0,
      timeElapsed: 30, // minutes
      events: [
        { type: "yellowCard", team: "away", player: "Player 8", minute: 17 }
      ]
    }
  ];
  
const users = [
    { id: "U1", username: "JohnDoe", balance: 1000 },
    { id: "U2", username: "JaneSmith", balance: 1500 },
    { id: "U3", username: "MikeJohnson", balance: 800 }
  ];

  const bets = [
    { id: "B1", userId: "U1", gameId: "G1", betType: "winner", pick: "home", amount: 50, odds: 1.8 },
    { id: "B2", userId: "U2", gameId: "G1", betType: "scoreExact", pick: "2-1", amount: 20, odds: 6.5 },
    { id: "B3", userId: "U3", gameId: "G2", betType: "winner", pick: "away", amount: 30, odds: 2.1 }
  ];
