require_relative 'p02_hashing'
require 'byebug'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    # byebug
    return if include?(num)
    self[num] << num
    resize! if @count + 1 > num_buckets
    @count += 1
  end

  def include?(num)
    self[num].include?(num)
  end

  def remove(num)
    return unless include?(num)
    @count -= 1
    self[num].delete(num)
  end

  private

  def [](num)
    # byebug
    @store[num.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = Array.new(num_buckets*2) { Array.new }

    @store.flatten.each do |el|
      new_buckets[el.hash % new_buckets.length] << el
    end

    @store = new_buckets
  end
end

# class ResizingIntSet
# attr_reader :count
#
# def initialize(num_buckets = 20)
#   @store = Array.new(num_buckets) { Array.new }
#   @count = 0
# end
#
# def insert(num)
#   return if include?(num)
#   self[num] << num
#   resize! if @count + 1 > num_buckets
#   @count += 1
# end
#
# def remove(num)
#   return unless include?(num)
#   @count -= 1
#   self[num].delete(num)
# end
#
# def include?(num)
#   byebug
#   self[num].include?(num)
# end
#
# def resize!
#   new_buckets = Array.new(num_buckets*2) { Array.new }
#   #byebug
#   @store.flatten.each do |el|
#     new_buckets[el % new_buckets.length] << el
#   end
#   # byebug
#   @store = new_buckets
# end
#
# private
#
# def [](num)
#   @store[num % num_buckets]# optional but useful; return the bucket corresponding to `num`
# end
#
# def num_buckets
#   @store.length
# end
# end
