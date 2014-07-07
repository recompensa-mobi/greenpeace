Greenpeace.configure do |env|
  env.requires "A", type: :int, doc: "Number of ABC's required"
  env.requires "B", type: :string

  env.may_have "C", type: :int, default: 1000, doc: "Number of C's"
end
