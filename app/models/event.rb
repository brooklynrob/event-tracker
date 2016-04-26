class Event < ActiveRecord::Base
      validates :event_title, presence: true,
                    length: { minimum: 0 }
end
