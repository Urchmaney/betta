# betta
A realtime Sport betting platform 


## Setup Development
Setup the main application serve by
- Run `git clone https://github.com/Urchmaney/betta.git`
- then `cd server` to change to the main serve directory.
- You can then follow the instruction in its readme to setup. follow these link. [setup main server (Ruby On Rails)](./server/README.md)

Now that you have the main server setup, we can now setup the websocket server.
- Make sure you are in the project root folder.
- run `cd websocker-server` to go into the websocker-server directory
- Now follow it setup instruction here. [setup websocket server (Node Js)](./websocker-server/README.md)


### Use Foreman
If you want to start both application with one command, you can use foreman.
- Install foreman to setup your development environment `gem install foreman`
- Run `foreman start` to start development server
