module FileBsearch
  class << self

    # args
    #   target ... File object || path for String object
    #
    # returner
    #   position in target file
    def index(target, *args)

      # check the target argument
      # - if not File object, open it as String for file path
      target = File.open(target.to_s) unless target.class == File

      # pass to main method
      search(target, *args)
    end

    private

    # args
    #     file ... File object
    #   needle ... search text
    #      min ... min of file pointer for search
    #      max ... max of file pointer for search
    #    block ... comparison process
    #
    # returner
    #   position in file
    def search(file, needle, min = 0, max = nil, &block)

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
          && (line = get_line(file)) \
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

    # get a line string at current position
    #
    # args
    #     file ... File object
    def get_line(file)

      if file.pos > 0

        # move pointer to before character
        file.seek(-1, IO::SEEK_CUR)

        # loop
        # - move pointer until reach to EOL of before line.
        until file.getc.match(/[\n\r]/)

          # move pointer to before character
          # - if EOS, break
          begin
            file.seek(-2, IO::SEEK_CUR)
          rescue Errno::EXXX
            break
          end
        end
      end

      file.gets
    end

  end
end
