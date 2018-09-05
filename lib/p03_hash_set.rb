require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    resize! if count == num_buckets
    self[key] << key
    self.count = count + 1
  end

  def include?(key)
    !self[key].empty?
  end

  def remove(key)
    @store[(key - 1) % num_buckets] = []
    self.count = count - 1
  end

  private

  attr_writer :count

  def [](num)
    @store[(num - 1) % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    @store.each do |arr| 
      new_store[(arr.first - 1) % new_store.length] << arr.first
    end
    @store = new_store
  end
end
