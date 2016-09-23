require 'byebug'

class Link
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
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(:head, nil)
    @tail = Link.new(:tail, nil)
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each do |link|
      return link.val if link.key == key
    end
    nil
  end

  def include?(key)
    each { |link| return true if link.key == key}
    false
  end

  def insert(key, val)
    link = Link.new(key, val)
    @tail.prev.next = link
    link.prev = @tail.prev
    @tail.prev = link
    link.next = @tail
    link
  end

  def remove(key)
    return if empty?
    to_delete = nil
    each{ |link| to_delete = link if link.key == key }
    return unless to_delete
    to_delete.prev.next = to_delete.next
    to_delete.next.prev = to_delete.prev
  end

  def each
    node = @head
    until node.next == @tail
      yield(node.next)
      node = node.next
    end
    @head
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
