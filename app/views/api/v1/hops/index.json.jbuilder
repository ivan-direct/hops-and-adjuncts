# frozen_string_literal: true

json.array! @hops, partial: 'api/v1/hops/hop', as: :hop
