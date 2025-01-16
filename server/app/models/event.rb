class Event < ApplicationRecord
  enum event_type: {
    goal: 0,
    yellow_card: 1,
    red_card: 2,
    substitution: 3
  }

  belongs_to :game
end
