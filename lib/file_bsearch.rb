require "file_bsearch/common"
require "file_bsearch/get_lines"
require "file_bsearch/main"
require "file_bsearch/version"

module FileBsearch
end

class File

  def self.bsearch(*args)
    FileBsearch.index(*args)
  end

  def bsearch(*args)
    FileBsearch.index(self, *args)
  end

  def self.bsearch?(*args)
    FileBsearch.exist?(*args)
  end

  def bsearch?(*args)
    FileBsearch.exist?(self, *args)
  end

  def self.bsearch_lines(*args)
    FileBsearch.get_lines(*args)
  end

  def bsearch_lines(*args)
    FileBsearch.get_lines(self, *args)
  end
end