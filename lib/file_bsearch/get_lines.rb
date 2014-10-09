# coding: utf-8

module FileBsearch
  class << self

    # returner
    #   Array object
    def get_lines(file, prefix, encoding = nil, *args)

      file      = init_file(file, encoding)
      prefix    = prefix.to_s

      # pass to scan method
      pos = scan_around_lines_seed(file, prefix, *args)

      if pos.is_a?(Integer)

        file.seek(pos)
        lines  = file.around_lines(/^#{Regexp.escape(prefix)}/)
        result = lines.chomp.split(/[\r\n]+/) if lines.bytesize > 0
      end

      result || []
    end

    private

    def scan_around_lines_seed(file, prefix, *args)
      scan(file, nil, *args) do |line|
        line[0, prefix.size] <=> prefix
      end
    end
  end
end