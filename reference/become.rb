require 'jruby'

class Object
  def become(cls)
    JRuby.reference(self).meta_class = cls
  end
end

class Foo; def go; "foo"; end; end
class Bar; def go; "bar"; end; end

foo = Foo.new
puts foo.go # => "foo"
foo.become Bar
puts foo.go # => "bar"
