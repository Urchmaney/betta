class GameChangeJob < ApplicationJob
  queue_as :game_queue_cube
  self.queue_name_prefix = "bull"

  def perform(id)
    
  end
end