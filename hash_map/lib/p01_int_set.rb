require 'byebug'

class MaxIntSet
  def initialize(max)
    @max = max
    @store = (0..max).to_a.map{ |n| false }
  end

  def insert(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num] = true
  end

  def remove(num)
    raise "Out of bounds" if num > @max || num < 0
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    return if include?(num)
    self[num] << num
  end

  def remove(num)
    return unless include?(num)
    self[num].delete(num)
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % 20]# optional but useful; return the bucket corresponding to `num`
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
    return if include?(num)
    self[num] << num
    resize! if @count + 1 > num_buckets
    @count += 1
  end

  def remove(num)
    return unless include?(num)
    @count -= 1
    self[num].delete(num)
  end

  def include?(num)
    byebug
    self[num].include?(num)
  end

  def resize!
    new_buckets = Array.new(num_buckets*2) { Array.new }
    #byebug
    @store.flatten.each do |el|
      new_buckets[el % new_buckets.length] << el
    end
    # byebug
    @store = new_buckets
  end

  private

  def [](num)
    @store[num % num_buckets]# optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end


end
