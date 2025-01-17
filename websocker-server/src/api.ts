import axios from 'axios';

export function fetchLeaderboard() {
  return axios.get('/users/leaderboard', {
    baseURL: process.env.SERVER_URL || "http://localhost:3000/"
  })
}