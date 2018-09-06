require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    @store[key.hash % num_buckets] << key
    self.count = count + 1
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    @store[key.hash % num_buckets] = []
    self.count = count - 1
  end

  private

  attr_writer :count

  def [](key)
    @store[key.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr| 
      arr.each do |key|
        new_store[key.hash % num_buckets] << key
      end
    end
    @store = new_store
  end
end
