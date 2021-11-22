# frozen_string_literal: true

class Beer < ApplicationRecord
  has_and_belongs_to_many :hops

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :checkins, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :rating, numericality: { greater_than_or_equal_to: 0, less_than: 5.01 }
  validates :style, inclusion: { in: %w[ipa stout other] }
end
