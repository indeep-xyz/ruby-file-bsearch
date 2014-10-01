module FileBsearch
  class << self

    # args
    #
    # returner
    #   true  ... data is exist
    #   false ... data is not exist
    def exist?(*args)

      # pass to index method
      # - true if returner is Integer
      index(*args).is_a?(Integer)
    end

    # args
    #   target ... File object || path for String object
    #
    # returner
    #   position in target file
    def index(target, *args, &block)

      file = to_file(target)

      # pass to scan method
      scan(file, *args, &block)
    end
  end
end
