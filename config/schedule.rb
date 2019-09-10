# frozen_string_literal: true

every 2.hours do
  rake 'api:items'
end
