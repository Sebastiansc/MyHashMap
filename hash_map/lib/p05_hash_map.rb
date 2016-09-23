require_relative 'p02_hashing'
require_relative 'p04_linked_list'
require 'byebug'

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
    if include?(key)
      bucket(key).remove(key)
    else
      resize! if @count + 1 > num_buckets
    end
    bucket(key).insert(key,val)
    @count += 1
  end

  def get(key)
    # debugger
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1
  end

  def each
    @store.each do |bucket|
      bucket.each do |link|
        yield(link.key,link.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_buckets = Array.new(num_buckets*2) { LinkedList.new }
    @store.each do |bucket|
      bucket.each do |link|
        new_buckets[link.key.hash % new_buckets.length].insert(link.key,link.val)
      end
    end
    @store = new_buckets
  end

  def bucket(key)
    b = key.hash % num_buckets
    return @store[b]
    # optional but useful; return the bucket corresponding to `key`
  end

end
