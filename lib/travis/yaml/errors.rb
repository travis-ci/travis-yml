module Travis
  module Yaml
    class Error < StandardError; end

    # Errors relating to implementation
    class InternalError < Error; end
    class MemoizedArgs < InternalError; end
    class StackTooHigh < InternalError; end
    class UnknownMessage < InternalError; end
    
    # Errors relating to user input
    class InputError < Error; end
    class UnexpectedConfigFormat < InputError; end
    class UnexpectedParentType < InputError; end
    class UnexpectedValue < InputError; end
  end
end
