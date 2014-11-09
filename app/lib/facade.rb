module Facade

  def inject(implementation)
    methods = implementation.public_methods

    methods.each do |method|
      define_delegate_method(implementation, method)
    end
  end

  private

  def define_delegate_method(implementation, method)
    define_method method do |*args, &block|
      implementation.send method, *args, &block
    end
  end

end
