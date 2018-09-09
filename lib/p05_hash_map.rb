require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable 
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    target_bucket = bucket(key)

    if target_bucket.include?(key)
      target_bucket.update(key, val)
    else
      resize! if count == num_buckets
      target_bucket.append(key, val)
      self.count += 1
    end
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    self.count -= 1
  end

  def each(&prc)
    store.each do |bucket|
      bucket.each { |node| prc.call([node.key, node.val]) }
    end
  end

  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  protected 

  attr_accessor :store
  attr_writer :count

  private

  def num_buckets
    store.length
  end

  def resize!
    new_num_buckets = num_buckets * 2
    new_store = Array.new(new_num_buckets) { LinkedList.new }
    self.each do |el|
      new_store[el[0].hash % (new_num_buckets)].append(el[0], el[1])
    end
    self.store = new_store
  end

  def bucket(key)
    store[key.hash % num_buckets]
  end
end
