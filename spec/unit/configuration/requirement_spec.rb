require 'spec_helper'
require 'greenpeace/configuration/requirement'

describe Greenpeace::Configuration::Requirement do
  subject do
    Greenpeace::Configuration::Requirement.new(
      :key,
      { type: :int, doc: 'DOC', defaults: { development: 5 } },
      'development')
  end

  describe '#identifier' do
    it 'returns the stringified key' do
      expect(subject.identifier).to eq('key')
    end
  end

  describe '#value' do
    context 'when the environment does not match the default' do
      subject do
        Greenpeace::Configuration::Requirement.new(
          :key,
          { type: :int, doc: 'DOC', defaults: { development: 5 } },
          'production')
      end

      context 'when an empty value is in the ENV' do
        before(:each) { configure_env_value '' }

        it 'raises an error' do
          expect { subject.value }.to raise_error
        end
      end

      context 'when a nil value is in the ENV' do
        before(:each) { configure_env_value nil }

        it 'raises an error' do
          expect { subject.value }.to raise_error
        end
      end

      context 'when a valid value is in the ENV' do
        before(:each) { configure_env_value '10' }

        it 'returns the value' do
          expect(subject.value).to eq(10)
        end
      end
    end

    context 'when the environment matches the default' do
      subject do
        Greenpeace::Configuration::Requirement.new(
          :key,
          { type: :int, doc: 'DOC', defaults: { development: 5 } },
          'development')
      end

      context 'when an empty value is in the ENV' do
        before(:each) { configure_env_value '' }

        it 'returns the default value' do
          expect(subject.value).to eq(5)
        end
      end

      context 'when a nil value is in the ENV' do
        before(:each) { configure_env_value nil }

        it 'returns the default value' do
          expect(subject.value).to eq(5)
        end
      end

      context 'when a valid value is in the ENV' do
        before(:each) { configure_env_value '10' }

        it 'returns the value' do
          expect(subject.value).to eq(10)
        end
      end
    end
  end
end
