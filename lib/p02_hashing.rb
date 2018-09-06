class Fixnum
  # Fixnum#hash already implemented via murmurhash
end

class Array
  def hash
    hashed = ''
    # return 100100100 if self.empty?
    self.each_with_index do |el, idx|
      hashed += idx.hash.to_s + el.hash.to_s
      # p hashed
    end
    hashed.hash.to_i
  end
end

class String
  def hash
    hashed = ''
    self.chars.each do |char|
      hashed += (char.ord % 51).to_s
    end
    return hashed.to_i 
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hashed = ''
    self.keys.sort.each do |key|
      hashed += (key.hash + self[key].hash).to_s
    end
    return hashed.to_i
  end
end
