require 'inline'

class CExecutor
  def initialize(code)
    @code = code
  end

  def execute(function_call, params)
    timestamp = Time.now.to_i
    executor = "
    class EvalExecutorWrapper#{timestamp}
      inline do |builder|
        builder.include '<iostream>'
        builder.add_compile_flags '-x c++', '-lstdc++'
        builder.c '#{@code}'
      end
    end
    EvalExecutorWrapper#{timestamp}.new.#{function_call}(#{params.to_s})
    "
    eval executor
  end
end