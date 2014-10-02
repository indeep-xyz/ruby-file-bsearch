module FileBsearch
  class << self

    private

    # get backward lines
    #
    # args
    #   file ... File object
    #            #pos value should be at SOL (Start Of Line)
    #   size ... indication of reading size
    #
    # returner
    #   String object as lines
    def backward_lines(file, size = 512)

      result = ""

      while file.pos > 0

        file.seek(-1, IO::SEEK_CUR)
        char = file.getc

        if char.match(/[\r\n]/) && result.size > size
          break
        else
          result.insert(0, char)
          file.seek(-1, IO::SEEK_CUR)
        end
      end

      result
    end

    # get a line string at current position
    #
    # args
    #     file ... File object
    def current_line(file)

      if file.pos > 0

        # move pointer to before character
        file.seek(-1, IO::SEEK_CUR)

        # loop
        # - move pointer until reach to EOL of before line.
        until file.getc.match(/[\n\r]/)

          # move pointer to before character
          if file.pos > 1
            file.seek(-2, IO::SEEK_CUR)
          else

            # if EOS, break
            file.rewind
            break
          end
        end
      end

      file.gets
    end

    # get forward lines
    #
    # args
    #   file ... File object
    #            #pos value should be at SOL (Start Of Line)
    #   size ... indication of reading size
    #
    # returner
    #   String object as lines
    def forward_lines(file, size = 512)

      result = ""

      while result.size < size && !file.eof?

        result += file.gets
      end

      result
    end

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
          && (line = current_line(file)) \
          && file.pos != old_pos

        old_pos = file.pos
        code    = block.call(line.chomp, needle)

        # for debug
        # p "-- #{needle}, " + {
        #   code: code,
        #   text: line.chomp,
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
        when  1 then max = file.pos - line.length
        else return file.pos - line.length
        end

        # move to mid point
        file.seek((min + max) / 2)
      end

      false
    end

    # args
    #   target ... File object || path for String object
    #
    # returner
    #   File object
    def to_file(target)

      # check the target argument
      # - if not File object, open it as String for file path
      return target if target.is_a?(File)
      File.open(target.to_s)
    end
  end
end
