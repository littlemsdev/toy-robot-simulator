module ToyRobotSimulator
  module ExecutionHooks
    def method_added(method_name)
      # only add hooks to only methods

      return if hooks.include?(method_name) || hooked_methods.include?(method_name)
      if only_methods.include?(method_name)
        add_hooks_to(method_name)
      else
        return
      end
    end

    def before_invoke(method_name, only: [])
      hooks << method_name
      only.each { |method| only_methods << method }
    end

    def hooks
      @hooks ||= []
    end

    def only_methods
      @only_methods ||= []
    end

    private

    def hooked_methods
      @hooked_methods ||= []
    end

    def add_hooks_to(method_name)
      # add this method to known hook mappings to avoid infinite
      # recursion when we redefine the method below
      hooked_methods << method_name

      # grab original method definition
      original_method = instance_method(method_name)

      # re-define the method, but notice how we reference the original
      # method definition
      define_method(method_name) do |*args, &block|
        # invoke the hook methods
        self.class.hooks.each do |hook|
          method(hook).call
        end

        # now invoke the original method
        original_method.bind(self).call(*args, &block)
      end
    end
  end
end
