require 'spec_helper'

describe Router::Matcher do
  subject(:matcher) { described_class.new }

  context 'when path is /' do
    it 'returns root resource' do
      expect(matcher.match('/')).to eq(resource: 'root')
    end
  end

  context 'when path is a valid resource' do
    context 'when it has params' do
      it 'returns resource and params correctly' do
        expect(matcher.match('/users/1')).to eq(resource: 'users', id: '1')
      end
    end

    context 'when it has no params' do
      it 'returns resource correctly' do
        expect(matcher.match('/users')).to eq(resource: 'users')
      end
    end
  end

  context 'when path is not a valid resource' do
    it 'returns nil' do
      expect(matcher.match('foo')).to be_nil
    end
  end
end
