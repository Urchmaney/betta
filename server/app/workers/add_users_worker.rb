
class AddUsersWorker
  include Sidekiq::Worker

  def perform(*args)
    users = JSON.parse(args[0])
      users.map do |user|
        User.find_or_create_by(external_id: user['id']) do |u|
          u.username = user['username']
          u.balance = user['balance']
          u.email = Faker::Internet.email
          u.password = "Secret1*3*5*##"
        end
      end
  end
end