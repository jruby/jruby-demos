require 'ffi'

module LibC
  extend FFI::Library
  # A callback parameter type
  callback :qsort_cmp, [ :pointer, :pointer ], :int
  
  attach_function :qsort, [ :pointer, :int, :int, :qsort_cmp ], :int
end

# build a native array of random numbers
p = MemoryPointer.new(:int, 10)
p.put_array_of_int32(0, (1..10).map {rand(50)})

puts "Before qsort #{p.get_array_of_int32(0, 10).join(', ')}"

# Ruby block used as a native callback!
LibC.qsort(p, 10, 4) do |p1, p2|
  i1 = p1.get_int32(0)
  i2 = p2.get_int32(0)
  i1 < i2 ? -1 : i1 > i2 ? 1 : 0
end

puts "After qsort #{p.get_array_of_int32(0, 10).join(', ')}"
