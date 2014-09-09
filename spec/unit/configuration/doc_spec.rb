require 'spec_helper'
require 'greenpeace/configuration/doc'

describe Greenpeace::Configuration::Doc do
  let(:test_class) { Greenpeace::Configuration::Doc }

  describe '#initialize' do
    context 'when no doc string is provided' do
      subject { test_class.new({}, :a) }

      it 'provides an "Undefined" documentation' do
        expect(subject.to_s).to eq('Undefined')
      end
    end

    context 'when a nil doc string is provided' do
      subject { test_class.new({ a: nil }, :a) }

      it 'raises an error' do
        expect { subject }.to raise_error
      end
    end

    context 'when a non-string doc is provided' do
      subject { test_class.new({ a: 1 }, :a) }

      it 'raises an error' do
        expect { subject }.to raise_error
      end
    end

    context 'when a valid string doc is provided' do
      subject { test_class.new({ a: 'a' }, :a) }

      it 'provides the given string doc' do
        expect(subject.to_s).to eq('a')
      end
    end
  end
end
