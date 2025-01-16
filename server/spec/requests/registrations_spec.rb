require 'swagger_helper'

RSpec.describe 'registrations', type: :request do

  path '/sign_up' do

    post('create registration') do
      tags 'Auth'
      consumes 'application/json'
      parameter name: 'registration', in: :body, schema: {
        type: :object,
        properties: { 
          email: { type: :string },
          password: { type: :string}, 
          full_name: { type: :string}, 
        },
        required: ['email', 'password', 'full_name']
      }
      response(201, 'successful') do
        let(:registration) {{ email: 'kingsobino@gmail.com', full_name: 'Kings Ply', password: "Secret1*3*5*##" }}
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
