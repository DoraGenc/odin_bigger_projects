require_relative 'bucketmanager.rb'

class HashMap

  def initialize
    @bucketmanager = BucketManager.new
    @capacity = bucketmanager.capacity
    @current_capacity = bucketmanager.current_capacity
    @load_factor = 0.75
    @edge_capacity = capacity * load_factor

  end

  def hash(key)
    hash_code = 0
    prime_number = 31
       
    key.each_char { |char| hash_code = prime_number * hash_code + char.ord }
       
    hash_code
  end

  def set(key, value)
    add_more_buckets if add_more_buckets?
  
    hash_code = hash(key) % capacity
    bucketmanager.set(hash_code, key, value)
  end

  def add_more_buckets?
    current_capacity >= edge_capacity
  end

  def add_more_buckets
    bucketmanager.add_more_buckets!
  end

  def get(key)
    hashcode = hash(key) % capacity
    return_value = bucketmanager.get(key, hashcode)
  end


  private

  attr_accessor :capacity, :edge_capacity
  attr_reader :load_factor, :bucketmanager, :current_capacity
end