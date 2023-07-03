require 'rails_helper'

RSpec.describe Product, type: :model do
  before do
    @category = Category.new(name: 'tree')
    @category.save
  end

  describe 'Validation' do
    it 'should save successfully when all required fields are set' do
      @product = Product.new(name: 'olive tree', price: 100, quantity: 5, category: @category)
      expect(@product).to be_valid
    end

    it 'should fail and show error message if name is not set' do
      @product = Product.new(name: nil, price: 100, quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should fail and show error message if price is not set' do
      @product = Product.new(name: 'olive tree', quantity: 5, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should fail and show error message if quantity is not set' do
      @product = Product.new(name: 'olive tree', price: 100, quantity: nil, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should fail and show error message if category is not set' do
      @product = Product.new(name: 'olive tree', price: 100, quantity: 5, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end

end