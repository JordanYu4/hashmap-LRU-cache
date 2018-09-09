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
    self.next, self.prev = nil, nil
  end
end

class LinkedList
  include Enumerable

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
    head.next
  end

  def last
    tail.prev
  end

  def empty?
    head.next == tail
  end

  def get(key)
    self.each { |node| return node.val if node.key == key }
  end

  def include?(key)
    self.each { |node| return true if node.key == key }
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    old_last = tail.prev
    old_last.next, new_node.prev = new_node, old_last
    new_node.next, tail.prev = tail, new_node
  end

  def update(key, val)
    self.each do |node| 
      if node.key == key
        node.val = val 
        break
      end
    end
  end

  def remove(key)
    node = first 
    while node != tail
      if node.key == key 
        condemned_node = node 
        node = condemned_node.next
        condemned_node.remove
      else
        node = node.next
      end
    end
  end

  def each(&prc)
    node = first 
    while node != tail
      prc.call(node)
      node = node.next
    end
  end

  def to_s
    inject([]) { |acc, node| acc << "[#{node.key}, #{node.val}]" }.join(", ")
  end

  private 

  attr_accessor :head, :tail
  
end
