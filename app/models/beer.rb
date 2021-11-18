# frozen_string_literal: true

class Beer < ApplicationRecord
  has_and_belongs_to_many :hops
end
