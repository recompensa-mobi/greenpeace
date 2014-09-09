require 'spec_helper'
require 'greenpeace/environment'

describe Greenpeace::Environment do
  let(:config) { double('config') }

  subject { Greenpeace::Environment.new(config) }

  context 'when the provided config has 2 settings' do
    before(:each) do
      allow(config).to receive(:settings).and_return([
        double('setting', identifier: 'foo', value: 'foovalue'),
        double('othersetting', identifier: 'bar', value: 'barvalue')])
    end

    describe '#initialize' do

      it 'imports the first setting key' do
        expect(subject.values).to have_key('foo')
      end

      it 'assigns the correct value to the first key' do
        expect(subject.values['foo']).to eq('foovalue')
      end

      it 'imports the second setting key' do
        expect(subject.values).to have_key('bar')
      end

      it 'assigns the correct value to the first key' do
        expect(subject.values['bar']).to eq('barvalue')
      end
    end

    describe '#method_missing' do
      it 'exposes the first key as a method' do
        expect(subject.foo).to eq('foovalue')
      end

      it 'exposes the second key as a method' do
        expect(subject.bar).to eq('barvalue')
      end

      it 'fails when accessing an unknown key' do
        expect { subject.foobar }.to raise_error
      end
    end
  end
end
