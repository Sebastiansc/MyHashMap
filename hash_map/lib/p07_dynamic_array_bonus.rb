require 'byebug'

class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity)
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  attr_reader :count

  def initialize(capacity = 8)
    @capacity = capacity
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= @store.length
    @store[i]
  end

  def []=(i, val)
    @store[i] = val
  end

  def capacity
    @capacity
  end

  def include?(val)

  end

  def push(val)
    @count += 1
    each do |index|
     unless @store[index]
       @store[index] = val
       break
     end
    end
  end

  def unshift(val)
    resize! if @count == capacity
    # byebug
    new_arr = StaticArray.new(@capacity)
    new_arr[0] = val
    each do |i|
      break unless @store[i]
      new_arr[i+1] = @store[i]
    end
    @store = new_arr
  end

  def pop
    # byebug
    popped = nil
    popped_idx = nil
    self.each do |idx|
      popped = self[idx] if self[idx+1].nil?
      popped_idx = idx if self[idx+1].nil?
      if popped != nil
        @count -= 1
        break
      end
    end
    self[popped_idx] = nil
    popped
  end

  def shift
    new_arr = StaticArray.new(@capacity)
    shifted = @store[0]
    @count -= 1
    each do |i|
      next if i == 0
      new_arr[i-1] = @store[i]
    end
    @store = new_arr
    return shifted
  end

  def first
    self[0]
  end

  def last
    popped = nil
    self.each do |idx|
      popped = self[idx] if self[idx+1].nil?
      if popped != nil
        break
      end
    end
    popped
  end

  def each
    @store.length.times{ |i| yield(i) }
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    return false unless [Array, DynamicArray].include?(other.class)
    # ...
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_store = StaticArray.new(@capacity * 2)
    each{ |i| new_store[i] = @store[i] }
    @store = new_store
  end
end
