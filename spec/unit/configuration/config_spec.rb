require 'spec_helper'
require 'greenpeace/configuration/config'

describe Greenpeace::Configuration::Config do
  describe '#requires' do
    it 'adds a new setting' do
      expect { subject.requires(:key) }
        .to change { subject.settings.size }.from(0).to(1)
    end

    it 'adds a requirement' do
      subject.requires(:key)

      expect(subject.settings.first)
        .to be_kind_of(Greenpeace::Configuration::Requirement)
    end

    it 'disallows duplicating keys' do
      subject.requires(:key)

      expect { subject.requires(:key) }.to raise_error
    end
  end

  describe '#may_have' do
    it 'adds a new setting' do
      expect { subject.may_have(:key) }
        .to change { subject.settings.size }.from(0).to(1)
    end

    it 'adds a requirement' do
      subject.may_have(:key)

      expect(subject.settings.first)
        .to be_kind_of(Greenpeace::Configuration::Option)
    end

    it 'disallows duplicating keys' do
      subject.may_have(:key)

      expect { subject.may_have(:key) }.to raise_error
    end
  end

end
