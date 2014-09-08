require "spec_helper"
require "greenpeace"

describe Greenpeace do
  it "allows the user to define a simple requirement" do
    ENV["KEY"] = "value"

    Greenpeace.configure do |env|
      env.requires :key
    end

    expect(Greenpeace.env.key).to eq("value")
  end

  it "allows the user to define a simple option" do
    ENV["KEY"] = "value"

    Greenpeace.configure do |env|
      env.may_have :key
    end

    expect(Greenpeace.env.key).to eq("value")
  end

  it "allows the user to define a defaulted simple option" do
    ENV["KEY"] = ""

    Greenpeace.configure do |env|
      env.may_have :key, default: "somevalue"
    end

    expect(Greenpeace.env.key).to eq("somevalue")
  end

  it "allows the user to define a typed requirement" do
    ENV["KEY"] = "10"

    Greenpeace.configure do |env|
      env.requires :key, type: :int
    end

    expect(Greenpeace.env.key).to eq(10)
  end

  it "allows the user to define a documented requirement" do
    ENV["KEY"] = ""

    expect {Greenpeace.configure {|env| env.requires :key, doc: "DOC"}}.
      to raise_error(/DOC/)
  end

  it "allows the user to define a environment-defaulted requirement" do
    ENV["KEY"] = ""

    Greenpeace.configure("development") do |env|
      env.requires :key, defaults: { development: "value" }
    end

    expect(Greenpeace.env.key).to eq("value")
  end
end

