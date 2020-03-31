module CarthageCacheRes

  class ShellCommandExecutor

    def execute(command)
      `#{command}`
    end

  end

end
