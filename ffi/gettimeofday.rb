require 'ffi'

class Timeval < FFI::Struct
  layout :tv_sec => :ulong, :tv_usec => :ulong
end

module LibC
  extend FFI::Library
  
  attach_function :gettimeofday, [ :pointer, :pointer ], :int
end

t = Timeval.new
LibC.gettimeofday(t.pointer, nil)
puts "seconds = #{t[:tv_sec]} µseconds = #{t[:tv_usec]}"
