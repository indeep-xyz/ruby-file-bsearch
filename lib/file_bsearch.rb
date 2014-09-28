require "file_bsearch/version"

module FileBsearch
  
end

class File

  include FileBsearch

  def self.bsearch(path, needle, min = 0, max = nil, &block)

    File.open(path) do |file|
      file.bsearch(needle, min, max, &block)
    end
  end

  def bsearch(needle, min = 0, max = nil, &block)

    max     ||= self.size
    block   ||= proc { |a, b| a <=> b }
    needle    = needle.to_s
    mid       = 0

    # reset position
    self.seek(0)

    # loop for search
    # - if over max point, not found
    # - if EOF, not found
    until max - self.pos < 0 || (line = self.gets).nil?

code = block.call(line.chomp, needle)

# for debug
p "-- #{needle}, " + {
  code: code,
  text: line.chomp,
   min: min,
   max: max,
   mid: mid,
   pos: self.pos
  }.to_s
sleep 0.05

      # comparison
      # - if not match, update either range values
      # - if match, return
      case code
      when -1 then min = mid 
      when  1 then max = mid
      else return true
      end

      # update mid point
      mid = (min + max) / 2 - 1

      # move to mid point
      self.seek(mid) rescue self.seek(min)

      # move to next line
      self.gets

      if self.nil?
        self.seek(min)
        self.gets
      end
    end

    return false
  end
end