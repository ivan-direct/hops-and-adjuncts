# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Brewery, type: :model do
  describe 'create' do
    it 'creates a new brewery' do
      expect(create(:brewery)).to be_truthy
    end
  end

  context 'validations' do
    it 'must have a name, city, and state' do
      brewery = Brewery.new
      expect(brewery.invalid?).to be_truthy
      brewery.name = 'Unique Beer Name'
      expect(brewery.invalid?).to be_truthy
      brewery.city = 'Fort Collins'
      expect(brewery.invalid?).to be_truthy
      brewery.state = 'CO'
      expect(brewery.valid?).to be_truthy
    end

    it 'must have a unique name' do
      brewery = create(:brewery)
      dup_brewery = brewery.dup
      expect(dup_brewery.invalid?).to be_truthy
    end
  end
end
