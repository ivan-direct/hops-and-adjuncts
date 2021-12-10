# frozen_string_literal: true

json.array! @adjuncts, partial: 'api/v1/adjuncts/adjunct', as: :adjunct
