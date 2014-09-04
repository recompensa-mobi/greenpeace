require "greenpeace/configuration/default"

describe Greenpeace::Configuration::Default do
  let(:test_class) {Greenpeace::Configuration::Default}
  let(:type) {double("type")}

  describe "#initialize" do
    context "when no default is provided" do
      subject {test_class.new(type, {}, :a)}

      it "provides a default nil value" do
        expect(subject.value).to be_nil
      end
    end

    context "when a valid value is provided" do
      subject {test_class.new(type, {a: "a"}, :a)}

      it "provides the value in the entry" do
        allow(type).to receive(:valid_value?).and_return(true)

        expect(subject.value).to eq("a")
      end
    end

    context "when an invalid value is provided" do
      subject {test_class.new(type, {a: "a"}, :a)}

      it "provides the value in the entry" do
        allow(type).to receive(:valid_value?).and_return(false)

        expect{subject.value}.to raise_error
      end
    end
  end
end
