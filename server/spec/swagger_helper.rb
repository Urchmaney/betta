# frozen_string_literal: true

require 'rails_helper'

RSpec.configure do |config|
  # Specify a root folder where Swagger JSON files are generated
  # NOTE: If you're using the rswag-api to serve API descriptions, you'll need
  # to ensure that it's configured to serve Swagger from the same folder
  config.openapi_root = Rails.root.join('swagger').to_s

  # Define one or more Swagger documents and provide global metadata for each one
  # When you run the 'rswag:specs:swaggerize' rake task, the complete Swagger will
  # be generated at the provided relative path under openapi_root
  # By default, the operations defined in spec files are added to the first
  # document below. You can override this behavior by adding a openapi_spec tag to the
  # the root example_group in your specs, e.g. describe '...', openapi_spec: 'v2/swagger.json'
  config.openapi_specs = {
    'v1/swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API V1',
        version: 'v1'
      },
      paths: {},
      servers: [
        {
          url: 'http://{defaultHost}',
          variables: {
            defaultHost: {
              default: "localhost:3000"
            }
          }
        }
      ],
      components: {
        securitySchemes: {
          bearer: {
            description: 'JWT key necessary to use API calls',
            type: :apiKey,
            name: 'Authorization',
            in: :header
          }
        },
        schemas: {
          User: {
            type: :object,
            properties: {
              id: { type: :integer },
              external_id: { type: :string },
              username: { type: :string },
              email: { type: :string }
            },
            example: {
              id: 1,
              external_id: "U1",
              username: "mike",
              email: "mike@gmail.com"
            }
          },
          Game: {
            type: :object,
            properties: {
              id: { type: :integer },
              external_id: { type: :string },
              home_team: { type: :string },
              away_team: { type: :string },
              away_score: { type: :integer },
              home_score: { type: :integer },
              time_elapsed: { type: :integer },
            },
            example: {
              id: 1,
              external_id: "G1",
              home_team: "Team 1",
              away_team: "Team 2",
              away_score: 2,
              home_score: 0,
              time_elapsed: 70,
            }
          },
          Event: {
            type: :object,
            properties: {
              id: { type: :integer },
              game_id: { type: :integer },
              event_type: { type: :string },
              for_home: { type: :boolean },
              player: { type: :string },
              minute: { type: :integer }
            },
            example: {
              id: 1,
              game_id: 1,
              event_type: "goal",
              for_home: true,
              player: "Player 1",
              minute: 50
            },
          },
          Bet: {
            type: :object,
            properties: {
              id: { type: :integer },
              game_id: { type: :integer },
              external_id: { type: :string },
              bet_type: { type: :string },
              pick: { type: :string },
              odd: { type: :decimal }
            },
            example: {
              id: 1,
              game_id: 1,
              external_id: "B1",
              bet_type: "winner",
              pick: "home",
              odd: 2.3
            }
          },
          BetPlacement: {
            type: :object,
            properties: {
              id: { type: :integer },
              user_id: { type: :integer },
              bet_id: { type: :integer },
              amount: { type: :integer },
              cashback: { type: :integer },
              won: { type: :boolean }
            },
            properties: {
              id: 1,
              user_id: 1,
              bet_id: 1,
              amount: 60,
              cashback: 90,
              won: false
            },
          }
        }
      }
    }
  }

  # Specify the format of the output Swagger file when running 'rswag:specs:swaggerize'.
  # The openapi_specs configuration option has the filename including format in
  # the key, this may want to be changed to avoid putting yaml in json files.
  # Defaults to json. Accepts ':json' and ':yaml'.
  config.openapi_format = :yaml
end
