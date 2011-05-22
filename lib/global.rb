class GlobalData
  # This is a Locator/Broker class for global data that
  # Needs to be accessible everywhere!
  def self.method_missing(sym, *args, &block)
    @@attrs ||= {}
    sym = sym.to_s
    if sym.include? "=" then
      @@attrs[sym.gsub('=','')] = args.first
    else
      if @@attrs[sym].class == Hash then
        return ValueProxy.new(@@attrs[sym])
      else
        return @@attrs[sym]
      end
    end
  end
end

# And ...

class ValueProxy
  def initialize(attrs)
    @attrs = attrs
  end
  def method_missing(sym,*args,&block)
    sym = sym.to_s
    if @attrs[sym] then
      if @attrs[sym].class == Hash then
        return ValueProxy.new(@attrs[sym])
      else
        return @attrs[sym]
      end
    end
  end
end
