require 'spec_helper'

describe Product, reset_test_db: true do
  context 'when saving a new product' do
    subject(:product) { described_class.new(name: 'Lemon', price: 1.00) }

    # TODO: Separate ActiveRecord model databases, so we have one for testing and one for development
    it 'saves correctly' do
      expect do
        product.save
      end.to change(described_class, :count).by(1)
    end
  end
end
