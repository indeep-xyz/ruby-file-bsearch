# coding: utf-8

require "file_char_licker"

module FileBsearch
  class << self

    # args
    #     file ... File object
    #   needle ... search text
    #      min ... min of file pointer for search
    #      max ... max of file pointer for search
    #    block ... comparison process
    #
    # returner
    #   position in file
    def scan(file, needle, min = 0, max = nil, &block)

      max     ||= file.size
      block   ||= proc { |a, b| a <=> b }
      needle    = needle.to_s
      old_pos   = -1

      # reset pointer
      file.rewind

      # loop for search
      # - if over max point, not found
      # - if EOF, not found
      # - if pointer did not moved, not found
      while max > file.pos \
          && (line = file.current_line) \
          && file.pos != old_pos

        old_pos = file.pos
        code    = block.call(line.chomp, needle)

        # for debug
        # p "-- #{needle}, " + {
        #   text: line.chomp,
        #   code: code,
        #    min: min,
        #    max: max,
        #    pos: file.pos
        #   }.to_s
        # sleep 0.05

        # comparison
        # - if not match, update either range values
        # - if match, return
        case code
        when -1 then min = file.pos - 1
        when  1 then max = file.pos - line.bytesize
        else return file.pos - line.bytesize
        end

        # move to mid point
        file.seek((min + max) / 2)
      end

      false
    end

    # args
    #   file ... File object || path for String object
    #
    # returner
    #   File object
    def init_file(file, encoding)

      # check the file argument
      # - if not File object, open it as String for file path
      file = File.open(file.to_s) unless file.is_a?(File)
      FileCharLicker.attach(file, encoding)

      file
    end
  end
end
