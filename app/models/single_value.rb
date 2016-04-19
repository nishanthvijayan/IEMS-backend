class SingleValue < ActiveRecord::Base
  def self.[](key)
    val = find_by_key(key.to_s)
    val.value if val
  end

  def self.[]=(key, value)
    val = find_by_key(key.to_s)
    if val
      value.nil? ? val.delete : val.update_attribute(:value, value)
    else
      create(key: key.to_s, value: value) unless value.nil?
    end
  end
end
