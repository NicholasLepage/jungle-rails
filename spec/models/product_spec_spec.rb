require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    
    before (:each) do
      @category = Category.new(name: "Clothes")
      @category.save
      @product = Product.new(name: "Nice T-shirt", price_cents: 99999, quantity: 10, category_id: @category.id)
    end

    it "should save successfully" do
      @product.save!
      expect(@product.save).to be true
    end

    it "should validate the name" do
      expect(@product.name).to be_present
    end

    it "should validate the price" do
      expect(@product.price).to be_present
    end

    it "should validate the quantity" do
      expect(@product.quantity).to be_present
    end

    it "should validate the category" do
      expect(@product.category).to be_present
    end

    it "should include error message when failed to save" do
      @product.name = nil 
      @product.valid?
      expect(@product.errors.to_a).to eql(["Name can't be blank"])
    end


  end
end

