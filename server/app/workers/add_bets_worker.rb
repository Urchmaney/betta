class AddBetsWorker
  include Sidekiq::Worker

  def perform(*args)
    bets = JSON.parse(args[0])
    
    bets.each
    
  end
end