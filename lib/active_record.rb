class ActiveRecord
  attr_accessor :id

  def self.all
    adapter.all
  end

  def self.adapter
    @adapter ||= JsonAdapter.new(self)
  end

  def self.count
    adapter.all.size
  end

  def initialize(attributes = {})
    attributes.each do |key, value|
      instance_variable_set("@#{key}", value)
    end
  end

  def save
    self.class.adapter.save(self)
  end

  def to_json(*_args)
    instance_variables_hash = instance_variables.each_with_object({}) do |var, hash|
      hash[var[1..]] = instance_variable_get(var)
    end
    JSON.pretty_generate(instance_variables_hash)
  end
end
