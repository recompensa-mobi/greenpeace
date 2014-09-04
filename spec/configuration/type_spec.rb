require "greenpeace/configuration/type"

describe Greenpeace::Configuration::Type do
  let(:test_class) {Greenpeace::Configuration::Type}

  describe "#initialize" do
    context "when no type is provided" do
      subject {test_class.new({}, :a)}

      it "provides a default string type" do
        expect(subject.to_s).to eq("string")
      end
    end

    context "when a nil type is provided" do
      subject{test_class.new({a: nil}, :a)}

      it "raises an error" do
        expect{subject}.to raise_error
      end
    end

    context "when a non-symbol type is provided" do
      subject{test_class.new({a: "string"}, :a)}

      it "raises an error" do
        expect{subject}.to raise_error
      end
    end

    context "when an invalid type is provided" do
      subject{test_class.new({a: :invalid}, :a)}

      it "raises an error" do
        expect{subject}.to raise_error
      end
    end
  end

  context "for the string type" do
    subject {test_class.new({a: :string}, :a)}

    describe "#valid_value?" do
      it "returns true for any string" do
        expect(subject).to be_valid_value("anything")
      end

      it "returns true for nil" do
        expect(subject).to be_valid_value(nil)
      end
    end

    describe "#convert" do
      it "converts the string to itself" do
        expect(subject.convert("anything")).to eq("anything")
      end
    end

    describe "#to_s" do
      it "returns string" do
        expect(subject.to_s).to eq("string")
      end
    end
  end

  context "for the int type" do
    subject {test_class.new({a: :int}, :a)}

    describe "#valid_value?" do
      it "returns false for any non-number" do
        expect(subject).not_to be_valid_value("a50")
      end

      it "returns true for any number" do
        expect(subject).to be_valid_value(50)
      end
    end

    describe "#convert" do
      it "converts the string to a number" do
        expect(subject.convert("50")).to eq(50)
      end

      it "raises an error if the string is not a number" do
        expect{subject.convert("a50")}.to raise_error
      end
    end

    describe "#to_s" do
      it "returns int" do
        expect(subject.to_s).to eq("int")
      end
    end
  end
end
