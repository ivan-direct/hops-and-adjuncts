# frozen_string_literal: true

class Beer < ApplicationRecord
  has_and_belongs_to_many :hops

  validates :name, presence: true
  validates :checkins, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :rating, inclusion: { in: Array.new(21) { |i| i * 0.25 } } # must be between 0-5 step size 0.25
  validates :style, inclusion: { in: %w[ipa stout other] }
end
