require_relative 'test_helper'

module Prestashop
  module Mapper
    describe Product do
      let(:product) { Product.new(attributes_for(:product)) }
      before do
        Client.stubs(:id_language).returns(2)
        Client.stubs(:id_supplier).returns(1)
        Client.stubs(:available_now).returns('Available now')
        Client.stubs(:available_later).returns('Available later')
      end

      it "should find id by reference and id supplier" do
        Product.expects(:find_by).returns(1)
        product.find?
        product.id.must_equal 1
      end

      it "should update model" do 
        Product.expects(:update).with(1, price: 100)
        product.stubs(:id).returns(1)
        product.update(price: 100)
      end

      it "should generate hash of feature" do 
        result = { id: 1, id_feature_value: 2 }
        product.feature_hash(1, 2).must_equal result
      end

      it "should generate hash of id features" do
        id_features = [{id_feature: 1, id_feature_value: 2}]
        product.stubs(:id_features).returns(id_features)
        product.expects(:feature_hash).with(1, 2)
        product.features_hash
      end
    end 
  end
end
