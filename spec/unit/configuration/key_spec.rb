require 'spec_helper'
require 'greenpeace/configuration/key'

describe Greenpeace::Configuration::Key do
  let(:test_class) { Greenpeace::Configuration::Key }

  describe '#initialize' do
    context 'when a nil key is provided' do
      subject { test_class.new(nil) }

      it 'raises an error' do
        expect { subject }.to raise_error
      end
    end

    context 'when a non-symbol key is provided' do
      subject { test_class.new('a') }

      it 'raises an error' do
        expect { subject }.to raise_error
      end
    end
  end

  subject { test_class.new(:a) }

  describe '#==' do
    it 'returns true for equal instances' do
      expect(subject).to eq(test_class.new(:a))
    end

    it 'returns false for different instances' do
      expect(subject).not_to eq(test_class.new(:b))
    end
  end

  describe '#to_s' do
    it 'returns the key' do
      expect(subject.to_s).to eq('a')
    end
  end

  describe '#identifier' do
    it 'returns the downcased key' do
      expect(subject.identifier).to eq('a')
    end
  end

  describe '#env_identifier' do
    it 'returns the upcased key' do
      expect(subject.env_identifier).to eq('A')
    end
  end
end
