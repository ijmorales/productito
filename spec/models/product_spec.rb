require 'spec_helper'

describe Product do
  context 'when saving a new product' do
    subject(:product) { described_class.new(name: 'Orange', price: 1.99) }

    # TODO: Separate ActiveRecord model databases, so we have one for testing and one for development
    it 'saves correctly' do
      expect do
        product.save
      end.to change(described_class, :count).by(1)
    end
  end
end
