require 'ffi'

module LibC
  extend FFI::Library
  
  attach_function :getpid, [ ], :uint
end

puts "Current process: #{LibC.getpid}"
