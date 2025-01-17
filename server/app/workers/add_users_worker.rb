
class AddUsersWorker
  include Sidekiq::Worker

  def perform(*args)
    users = JSON.parse(args[0])

    User.create(
      users.map do |user|
        {
          external_id: user['id'],
          username: user['username'],
          balance: user['balance'],
          email: Faker::Internet.email,
          password: "Secret1*3*5*##"
        }
      end
  )
  end
end