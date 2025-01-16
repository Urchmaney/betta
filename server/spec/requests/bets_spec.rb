require 'swagger_helper'

RSpec.describe 'bets', type: :request do
 
  let(:user) {User.create!(full_name: "Lukas", email: "luke@gmail.com", password: "Secret1*3*5*##")}
  let(:game) {Game.create!(game_id: 2, home_team: "Man", away_team: "Arsenal")}

  path '/bets' do
    post('create bet') do
      tags 'Bet'
      security [bearer: []]
      consumes 'application/json'
      parameter name: 'bets', in: :body, schema: {
        type: :object,
        properties: {
          bets: { 
            type: :array, 
            items: { 
              type: :object, 
              properties: { 
                game_id: { type: :integer },
                bet_type: { type: :string}, 
                pick: { type: :string}, 
                amount: { type: :number }, 
              }
            } 
          },
        },
        required: [ 'bets']
      }, description: "Bet List"
    
      response(201, 'successful') do
        let(:Authorization) { "Bearer #{sign_in_as(user)[1]}" }
        let(:bets) { { bets: [{game_id: game.id, bet_type: 'winner', pick: 'home', amount: 50 }]  } }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(422, 'bad request') do
        let(:Authorization) { "Bearer #{sign_in_as(user)[1]}" }
        let(:bets) { { bets: [
          {game_id: game.id, bet_type: 'winner', pick: 'home', amount: 400 },
          {game_id: game.id, bet_type: 'score_exact', pick: '2-1', amount: 250 },
          ] } }
        
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

  path '/users/{id}/bets' do
    parameter name: 'id', in: :path, type: :string, description: 'id'


    get('list bets') do
      tags 'Bet'
      security [bearer: []]
      response(200, 'successful') do
        let(:id) { '123' }
        let(:Authorization) { "Bearer #{sign_in_as(user)[1]}" }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end

      response(401, 'unauthorized') do
        let(:id) { '123' }
        let(:Authorization) { "Bearer #{::Base64.strict_encode64('bogus:bogus')}" }

        run_test!
      end
    end
  end
end
