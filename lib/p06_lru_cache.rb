require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if map.include?(key)
      update_node!(map[key])
    else
      eject! if count == max 
      self.store.append(key, calc!(key))
      self.map[key] = store.last 
    end
    store.last.val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  protected 

  attr_accessor :map, :store

  private

  attr_reader :prc, :max

  def calc!(key)
    prc.call(key)
  end

  def update_node!(node)
    self.store.remove(node.key)
    self.store.append(node.key, node.val)
  end

  def eject!
    ejected_key = store.first.key 
    store.remove(ejected_key)
    self.map.delete(ejected_key)
  end
end
