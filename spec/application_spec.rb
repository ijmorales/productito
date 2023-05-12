require 'spec_helper'

describe Application do
  include AuthenticationHelper

  subject(:app) { described_class.new }

  context "when doing a GET '/'" do
    let(:response) { authenticated_request :get, '/' }

    context 'when request is authenticated' do
      it 'returns a 200 status code and a hello world in the body' do
        expect(response.status).to eq(200)
        expect(response.body).to include 'Hello World'
      end
    end

    context 'when request is not authenticated' do
      let(:response) { get '/' }

      it 'returns a 401' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'when doing a GET /products' do
    context 'when request is authenticated' do
      let(:response) { authenticated_request :get, '/products' }

      it 'returns a 200 status code and the products index' do
        expect(response.status).to eq 200
        expect(response.body).to eq Product.all.to_json
      end
    end

    context 'when request is not authenticated' do
      let(:response) { get '/products' }

      it 'returns a 401' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'when doing a GET /products/3' do
    context 'when request is authenticated' do
      let(:response) { authenticated_request :get, '/products/3' }

      it 'returns a 200 status code and the products show' do
        expect(response.status).to eq 200
        expect(response.body).to include 'Products show'
      end
    end

    context 'when request is not authenticated' do
      let(:response) { get '/products' }

      it 'returns a 401' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'when doing a POST request to /products', reset_test_db: true do
    let(:params) { { name: 'Lemon', price: 1.00 } }

    # Mock the wait time so the spec does not take ages to run
    before do
      allow(Product).to receive(:create_async).and_wrap_original do |method, *args, **kwargs|
        kwargs[:wait] = 0.2
        method.call(*args, **kwargs)
      end
    end

    context 'when request is authenticated' do
      let(:response) { authenticated_request :post, '/products', params: }

      it 'schedules product creation, returns a message, and creates a new product after 5 seconds' do
        expect do
          expect(response.status).to eq 200
          expect(response.body).to include 'Product creation scheduled'
        end.not_to change(Product, :count)

        expect { sleep 0.3 }.to change(Product, :count).by(1)
      end
    end

    context 'when request is not authenticated' do
      let(:response) { get '/products' }

      it 'returns a 401' do
        expect(response.status).to eq 401
      end
    end
  end

  context 'when doing a request to a non-existent route' do
    context 'when request is authenticated' do
      let(:response) { authenticated_request :get, '/foo' }

      it 'returns a 404 status code' do
        expect(response.status).to eq 404
        expect(response.body).to include 'Not found'
      end
    end

    context 'when request is not authenticated' do
      let(:response) { get '/products' }

      it 'returns a 401' do
        expect(response.status).to eq 401
      end
    end
  end
end
