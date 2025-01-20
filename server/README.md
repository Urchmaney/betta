# Application Server (Ruby On Rails)
This is main application server that store all user datas, games and bets.
It use 
- SQLITE (Database)
- Sidekiq (Background Jobs)
- Redis (Async Communication)


## Setup
- Run `bundle install` to install application dependencies
- Setup environment variables. there is a file `.env.example` you can use as a sample or copy from the code below.
```
APP_SECRET = ...
REDIS_HOST = ...
REDIS_PORT = ...
REDIS_DB = ...
```
Redis configuration can be omitted if you are using a local server in development.
- Run `rails db:migrate` to setup migrations
- Run `rails db:seed` to add mock data
- Now run `rails s` to start only this application
- Also to start the sidekiq server that runs background jobs, open
    -   Open a new terminal with the `server` as the current working directory
    -   Run `bundle exec sidekiq -q default -q leaderboard`


## API Docs
You can view the API Documentation by following the url `{host}/api-docs` which will bring a swaggar interface to test the APIS.

## Getting Authentication Token
After opening the `API Docs` above, a swaggar UI appears. You should `sign up` if you don't have an account. And then `sign in`. After signing in, you get a response, but the authentication token is not in the body but rather in the headerS of the response. You can find it under the key `x-session-token`. Copy the value and you have your authentication token.
You can use it with swaggar and to activate the `client` and `simulator`.