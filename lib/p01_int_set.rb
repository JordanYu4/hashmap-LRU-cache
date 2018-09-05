class MaxIntSet

  def initialize(max)
    @max = max 
    @store = Array.new(max, false)
  end
  
  def insert(num)
    validate!(num)
    self.store[num - 1] = true
  end
  
  def remove(num)
    validate!(num)
    self.store[num - 1] = false
  end
  
  def include?(num)
    validate!(num)
    store[num - 1]
  end
  
  protected

  attr_accessor :store
  attr_reader :max

  def is_valid?(num)
    num.between?(1, max)
  end

  def validate!(num)
    raise "Out of bounds" unless is_valid?(num)
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    self[num] << num
  end

  def remove(num)
    @store[(num - 1) % num_buckets] = []
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[(num - 1) % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    resize! if count == num_buckets
    self[num] << num
    self.count = count + 1
  end

  def remove(num)
    @store[(num - 1) % num_buckets] = []
    self.count = count - 1
  end

  def include?(num)
    !self[num].empty?
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
