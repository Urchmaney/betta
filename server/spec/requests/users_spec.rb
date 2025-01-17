require 'swagger_helper'

RSpec.describe 'users', type: :request do

  path '/users/leaderboard' do
    get('leader board') do
      tags 'Users'
      response(200, 'successful') do
    
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
