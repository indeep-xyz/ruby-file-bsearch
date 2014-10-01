module FileBsearch
  class << self

    # returner
    #   Array object
    def get_lines(target, prefix, *args)

      result = []
      file   = to_file(target)

      # pass to scan method
      pos = scan(file, nil, *args) do |line|
        line[0, prefix.size] <=> prefix
      end

      if pos.is_a?(Integer)

        needle = Regexp.new("^#{Regexp.escape(prefix)}")
        result = around_lines(file, pos, needle)
      end

      result
    end

    private

    # get lines around for passed file#pos
    #
    # args
    #   file   ... File object
    #   pos    ... starting point for file#pos
    #              require to be within contiguous range
    #   needle ... RegExp object for contiguous check
    # 
    # returner
    #   Array object
    def around_lines(file, pos, needle)

      # scan
      min = scan_contiguous_min(file, pos, needle) || pos
      max = scan_contiguous_max(file, pos, needle) || pos

      # read
      file.seek(min)
      lines = file.read(max - min).chomp

      # return
      return lines.split(/[\r\n]+/) if lines.size > 0
      []
    end

    # scan min file#pos of contiguous range.
    #
    # args
    #   file   ... File object
    #   pos    ... starting point for file#pos
    #              require to be within contiguous range
    #   needle ... RegExp object for contiguous check
    #   step   ... buffer size for check processing
    #
    # returner
    #   Integer object for file#pos
    #   EOS of matched line
    def scan_contiguous_min(file, pos, needle, step = 512)

      file.pos = pos
      min      = nil

      loop do

        lines     = backward_lines(file, step)
        lines_pos = lines.index(needle)
        file_pos  = file.pos

        # for debug
        # p [
        #       lines: lines,
        #   lines_pos: lines_pos,
        #    file_pos: file_pos
        #   ].to_s
        # sleep 0.05

        if lines_pos.nil?
          break
        else
          min = file_pos + lines_pos
          break if lines_pos > 0 || file_pos < 1
        end
      end

      min
    end

    # scan max file#pos of contiguous range.
    #
    # args
    #   file   ... File object
    #   pos    ... starting point for file#pos
    #              require to be within contiguous range
    #   needle ... RegExp object for contiguous check
    #   step   ... buffer size for check processing
    #
    # returner
    #   Integer object for file#pos
    #   EOL of matched line
    def scan_contiguous_max(file, pos, needle, step = 512)

      file.pos = pos
      max      = nil

      loop do

        # file#pos before #forward_lines
        pos_old   = file.pos

        lines     = forward_lines(file, step)
        lines_pos = lines.rindex(needle)

        # for debug
        # p [
        #   lines: lines,
        #   lines_pos: lines_pos,
        #   file_pos: file.pos
        #   ].to_s
        # sleep 0.05

        # if did not match needle
        # - returner is last set value to 'max'
        break if lines_pos.nil?

        lines_end_pos = lines.index(/([\r\n]+?)/, lines_pos)

        if file.eof?
          max = (lines_end_pos.nil?) ? file.size : pos_old + lines_end_pos
          break
        else
          max = pos_old + lines_end_pos

          break if lines_end_pos < lines.size - 1
        end

      end

      max
    end
  end
end