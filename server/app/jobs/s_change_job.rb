class SChangeJob
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(id)
    p id
  end
end