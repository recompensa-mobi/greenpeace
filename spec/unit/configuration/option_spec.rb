require "spec_helper"
require "greenpeace/configuration/option"

describe Greenpeace::Configuration::Option do
  subject do
    Greenpeace::Configuration::Option.new(
      :key,
      type: :int, doc: "DOC", default: 5)
  end

  describe "#identifier" do
    it "returns the stringified key" do
      expect(subject.identifier).to eq("key")
    end
  end

  describe "#value" do
    context "when an empty value is in the ENV" do
      before(:each) {set_env_value ""}

      it "returns the default value" do
        expect(subject.value).to eq(5)
      end
    end

    context "when a nil value is in the ENV" do
      before(:each) {set_env_value nil}

      it "returns the default value" do
        expect(subject.value).to eq(5)
      end
    end

    context "when a valid value is in the ENV" do
      before(:each) {set_env_value "10"}

      it "returns the value" do
        expect(subject.value).to eq(10)
      end
    end

  end

end
