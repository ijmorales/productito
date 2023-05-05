require 'spec_helper'

describe Application do
  subject(:app) { described_class.new }

  context "when doing a GET '/'" do
    let(:response) { get '/' }

    it 'returns a 200 status code and a hello world in the body' do
      expect(response.status).to eq(201)
      expect(response.body).to eq 'Hello World'
    end
  end
end
