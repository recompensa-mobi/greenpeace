require 'spec_helper'
require 'greenpeace/configuration/default'

describe Greenpeace::Configuration::Default do
  let(:test_class) { Greenpeace::Configuration::Default }
  let(:type) { double('type') }

  describe '#initialize' do
    context 'when no default is provided' do
      subject { test_class.new(type, {}, :a, :as) }

      it 'provides a default nil value' do
        expect(subject.value('development')).to be_nil
      end
    end

    context 'when a valid value is provided directly' do
      subject { test_class.new(type, { a: 'a' }, :a, :as) }

      it 'provides the value in the entry' do
        allow(type).to receive(:valid_value?).and_return(true)

        expect(subject.value('development')).to eq('a')
      end
    end

    context 'when an invalid value is provided directly' do
      subject { test_class.new(type, { a: 'a' }, :a) }

      it 'raises an error' do
        allow(type).to receive(:valid_value?).and_return(false)

        expect { subject.value('development') }.to raise_error
      end
    end

    context 'when a valid value is provided for an environment' do
      subject { test_class.new(type, { as: { development: 'a' } }, :a, :as) }

      before(:each) { allow(type).to receive(:valid_value?).and_return(true) }

      it 'provides the value for the environment' do
        expect(subject.value('development')).to eq('a')
      end

      it 'provides the value for the environment as a symbol' do
        expect(subject.value(:development)).to eq('a')
      end

      it 'provides a default nil value for other environments' do
        expect(subject.value('production')).to be_nil
      end
    end

    context 'when an invalid value is provided for an environment' do
      subject { test_class.new(type, { as: { development: 'a' } }, :a, :as) }

      it 'raises an error' do
        allow(type).to receive(:valid_value?).and_return(false)

        expect { subject.value }.to raise_error
      end
    end
  end

  describe '#environment_value?' do
    subject { test_class.new(type, { as: { development: 'a' } }, :a, :as) }

    before(:each) { allow(type).to receive(:valid_value?).and_return(true) }

    it 'returns true for the environment which has a value' do
      expect(subject).to be_environment_value('development')
    end

    it 'returns true for the environment which has a value as a symbol' do
      expect(subject).to be_environment_value(:development)
    end

    it 'returns false for other environments do' do
      expect(subject).not_to be_environment_value('production')
    end
  end
end
