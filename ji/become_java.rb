require 'java'
require 'jruby/core_ext'

class MyRubyClass
  def hello
    puts 'hello, world'
  end

  def goodbye
    puts "goodbye, world"
  end
end
MyRubyClass.become_java!

mrc = MyRubyClass.new

# inspect it
Java::Inspector.inspect_object mrc
# invoke it
Java::Invoker.invoke_method mrc, "hello"