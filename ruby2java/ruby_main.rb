class RubyMain
  def self.main(args)
    args.each {|arg| puts arg}
  end
end

if defined? Ruby2Java
  RubyMain.static_signature :main, [java.lang.String[]] => Java::void
end
