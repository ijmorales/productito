require 'spec_helper'

describe Application do
  subject(:app) { described_class.new }

  context "when doing a GET '/'" do
    let(:response) { get '/' }

    it 'returns a 200 status code and a hello world in the body' do
      expect(response.status).to eq(200)
      expect(response.body).to eq 'Hello World'
    end
  end

  context 'when doing a GET /products' do
    let(:response) { get '/products' }

    it 'returns a 200 status code and the products index' do
      expect(response.status).to eq 200
      expect(response.body).to eq 'Products index'
    end
  end

  context 'when doing a GET /products/3' do
    let(:response) { get '/products/3' }

    it 'returns a 200 status code and the products show' do
      expect(response.status).to eq 200
      expect(response.body).to eq 'Products show'
    end
  end

  context 'when doing a request to a non-existent route' do
    let(:response) { get '/foo' }

    it 'returns a 404 status code' do
      expect(response.status).to eq 404
      expect(response.body).to eq 'Not found'
    end
  end
end
