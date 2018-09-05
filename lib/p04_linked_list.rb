class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    prev.next = self.next
    self.next.prev = self.prev
    self.next = nil
    self.prev = nil
  end
end

class LinkedList

  def initialize
    @head = Node.new
    @tail = Node.new
    @head.next = tail
    @tail.prev = head
  end

  def [](i)
    each_with_index { |node, j| return node if i == j }
    nil
  end

  def first
  end

  def last
  end

  def empty?
    head.next == tail
  end

  def get(key)
  end

  def include?(key)
  end

  def append(key, val)
  end

  def update(key, val)
  end

  def remove(key)
    get(key).remove
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  # end

  private 

  attr_accessor :head, :tail
  
end
