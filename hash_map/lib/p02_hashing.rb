require 'byebug'
class Fixnum
  # Fixnum#hash already implemented for youpry
end

class Array
  def hash
    xor = 0

    each_with_index do |el, index|
      xor = xor ^ (index.hash + el.hash)
    end
    # byebug
    xor
  end
end

class String
  def hash
    xor = 0

    chars.each_with_index do |el, index|
      xor = xor ^ (index + el.ord).hash
    end
    # byebug
    xor
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    xor = 0
    sorted = keys.sort

    sorted.each_with_index do |el, index|
      xor = xor ^ (index + el.to_s.ord).hash
    end
    # byebug
    xor
  end
end
