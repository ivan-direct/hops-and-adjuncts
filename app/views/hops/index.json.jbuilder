# frozen_string_literal: true

json.array! @hops, partial: 'hops/hop', as: :hop
