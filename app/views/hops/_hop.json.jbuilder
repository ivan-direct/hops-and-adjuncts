# frozen_string_literal: true

json.extract! hop, :id, :created_at, :updated_at
json.url hop_url(hop, format: :json)
