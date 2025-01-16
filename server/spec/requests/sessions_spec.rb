require 'swagger_helper'

RSpec.describe 'sessions', type: :request do
  let(:user) {User.create!(full_name: "Lukas", email: "luke@gmail.com", password: "Secret1*3*5*##")}

  path '/sign_in' do
    post('create session') do
      tags 'Auth'
      consumes 'application/json'
      parameter name: 'login', in: :body, schema: {
        type: :object,
        properties: { 
          email: { type: :string },
          password: { type: :string}, 
        },
        required: ['email', 'password']
      }
      response(201, 'successful') do
      let(:login) {{ email: user.email, password: "Secret1*3*5*##" }}
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
