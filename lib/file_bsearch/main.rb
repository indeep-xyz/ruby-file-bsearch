# coding: utf-8

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
    #   file ... File object || path for String object
    #
    # returner
    #   position in target file
    def index(file, needle, encoding = nil, *args, &block)

      file = init_file(file, encoding)

      # pass to scan method
      scan(file, needle, *args, &block)
    end
  end
end
