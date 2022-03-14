require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    it 'should save a product when all fields are entered' do
      @category = Category.new(name: 'Food')
      @product = Product.new(name: 'Beans', price: 3, quantity: 1000, category: @category)
      expect(@product).to be_valid
    end
    it 'should not save a product when name is not entered' do
      @category = Category.new(name: 'Food')
      @product = Product.new(name: nil, price: 3, quantity: 1000, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end
    it 'should not save a product when price is not entered' do
      @category = Category.new(name: 'Food')
      @product = Product.new(name: 'Beans', quantity: 1000, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end
    it 'should not save a product when quantity is not entered' do
      @category = Category.new(name: 'Food')
      @product = Product.new(name: 'Beans', price: 3, category: @category)
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end
    it 'should not save a product when category is not entered' do
      @product = Product.new(name: 'Beans', price: 3, quantity: 1000)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end
  end
end
