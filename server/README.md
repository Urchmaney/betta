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
- Now run `rails s` to start only this application
- Also to start the sidekiq server that runs background jobs, open
    -   Open a new terminal with the `server` as the current working directory
    -   Run `bundle exec sidekiq -q default`


## API Docs
You can view the API Documentation by following the url `{host}/api-docs` which will bring a swaggar interface to test the APIS.
