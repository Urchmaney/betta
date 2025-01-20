require 'swagger_helper'

RSpec.describe 'bets', type: :request do
 
  let(:user) {User.create!(username: "Lukas", email: "luke@gmail.com", password: "Secret1*3*5*##")}
  let(:game) {Game.create!(external_id: 2, home_team: "Man", away_team: "Arsenal")}
  let(:bet) { Bet.create(game: game, bet_type: "winner", pick: "away", odd: 1.5 )}

  path '/bets' do
    post('create bet') do
      tags 'Bet'
      security [bearer: []]
      consumes 'application/json'
      parameter name: 'bet_placement', in: :body, schema: {
        type: :object,
        properties: {
          bet_placement: {
            type: :object, 
            properties: { 
              bet_id: { type: :integer },
              amount: { type: :number }, 
            }
          },
        },
        required: ['bet_placement']
      }, description: "Bet List"
    
      response(201, 'successful') do
        let(:Authorization) { "Bearer #{sign_in_as(user)[1]}" }
        let(:bet_placement) { { bet_placement: {bet_id: bet.id, amount: 50 } } }

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
        let(:bet_placement) { { bet_placement: {bet_id: game.id, amount: 700 } } }
        
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
