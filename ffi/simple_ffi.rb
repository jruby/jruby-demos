require 'ffi'

module LibC
  extend FFI::Library
  ffi_lib FFI::Library::LIBC
  
  attach_function :getpid, [ ], :uint
end

puts "Current process: #{LibC.getpid}"
