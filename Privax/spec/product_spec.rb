require 'product'

describe Product do
  let(:test_file) { 'spec/fixtures/products.json' }

  describe 'attributes' do
    it "allow reading and writing for :name" do
      subject.name = 'Test'
      expect(subject.name).to eq('Test')
    end
  end

  describe '.all' do
    it 'returns array of product objects from @@file' do
      Product.load(test_file)
      products = Product.all
      expect(products.class).to eq(Array)
      expect(products.length).to eq(2)
      expect(products.first.class).to eq(Product)
    end
  end

  describe '#initialize' do
    context 'with no options' do
      let(:no_options) { Product.new }

      it 'sets a default of "" for :name' do
        expect(subject.name).to eq("")
      end
    end

    context 'with custom options' do
      it 'allows changing the :name'
      it 'allows changing the :discount_tiers'
    end
  end
end
